/* 
*Copyright (c) 2021, Alibaba Group;
*Licensed under the Apache License, Version 2.0 (the "License");
*you may not use this file except in compliance with the License.
*You may obtain a copy of the License at

*   http://www.apache.org/licenses/LICENSE-2.0

*Unless required by applicable law or agreed to in writing, software
*distributed under the License is distributed on an "AS IS" BASIS,
*WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*See the License for the specific language governing permissions and
*limitations under the License.
*/

//
// Usage: 
// At Cycle N: downstream consumer sees request_out and request_valid_out, consumes the entry, sets issue_ack_in (which triggers read_complete)
// At Cycle N+1: FIFO Queue sends out next entry
//

module fifo_queue
#(
    parameter SINGLE_ENTRY_WIDTH_IN_BITS    = 64,
    parameter QUEUE_PTR_WIDTH_IN_BITS       = 3
)
(
    input wire                                          clk_in,
    input wire                                          reset_in,

    output wire                                         is_empty_out,
    output wire                                         is_full_out,
    output wire                                         is_almost_full_out,

    input wire [SINGLE_ENTRY_WIDTH_IN_BITS - 1 : 0]     request_in,
    input wire                                          request_valid_in,
    output wire                                         issue_ack_out,

    output reg [SINGLE_ENTRY_WIDTH_IN_BITS - 1 : 0]     request_out,
    output reg                                          request_valid_out,
    input wire                                          issue_ack_in
);

//localparam QUEUE_PTR_WIDTH_IN_BITS = $clog2(QUEUE_SIZE);
localparam QUEUE_SIZE = 1 << QUEUE_PTR_WIDTH_IN_BITS;

wire [QUEUE_SIZE - 1 : 0]                   write_qualified;
wire [QUEUE_SIZE - 1 : 0]                   read_complete;
wire [SINGLE_ENTRY_WIDTH_IN_BITS  - 1 : 0]  storage_output;

wire [QUEUE_SIZE - 1 : 0]                   fifo_entry_valid;

reg  [QUEUE_PTR_WIDTH_IN_BITS     - 1 : 0]  write_ptr;
reg  [QUEUE_PTR_WIDTH_IN_BITS     - 1 : 0]  read_ptr;

wire [QUEUE_PTR_WIDTH_IN_BITS     - 1 : 0]  next_write_ptr = (write_ptr == {(QUEUE_PTR_WIDTH_IN_BITS){1'b1}} ?
                                                                        {(QUEUE_PTR_WIDTH_IN_BITS){1'b0}} :
                                                                        write_ptr + 1'b1);
wire [QUEUE_PTR_WIDTH_IN_BITS     - 1 : 0]  next_read_ptr  = (read_ptr  == {(QUEUE_PTR_WIDTH_IN_BITS){1'b1}} ?
                                                                        {(QUEUE_PTR_WIDTH_IN_BITS){1'b0}} :
                                                                        read_ptr + 1'b1);

wire [QUEUE_PTR_WIDTH_IN_BITS - 1 : 0]      first_one_index_forward;
wire                                        one_is_found_forward;
wire [QUEUE_PTR_WIDTH_IN_BITS - 1 : 0]      first_one_index_backward;
wire                                        one_is_found_backward;

find_first_one_index_forward
#(
        .VECTOR_LENGTH          (QUEUE_SIZE),
        .MAX_OUTPUT_WIDTH       (QUEUE_PTR_WIDTH_IN_BITS)
)
u_find_first_one_index_forward
(
        .vector_in              (~fifo_entry_valid),
        .first_one_index_out    (first_one_index_forward),
        .one_is_found_out       (one_is_found_forward)
);

find_first_one_index_backward
#(
        .VECTOR_LENGTH          (QUEUE_SIZE),
        .MAX_OUTPUT_WIDTH       (QUEUE_PTR_WIDTH_IN_BITS)
)
u_find_first_one_index_backward
(
        .vector_in              (~fifo_entry_valid),
        .first_one_index_out    (first_one_index_backward),
        .one_is_found_out       (one_is_found_backward)
);

assign is_full_out   = &fifo_entry_valid;
assign is_empty_out  = &(~fifo_entry_valid);
assign issue_ack_out = ~is_full_out | (issue_ack_in & request_valid_out & request_valid_in);

assign is_almost_full_out =     one_is_found_forward & one_is_found_backward 
                                & first_one_index_forward == first_one_index_backward;

// read/write ptr management
always@(posedge clk_in or negedge reset_in)
begin
    if(!reset_in)
    begin
        write_ptr           <= {(QUEUE_PTR_WIDTH_IN_BITS){1'b0}};
        read_ptr            <= {(QUEUE_PTR_WIDTH_IN_BITS){1'b0}};
        request_out         <= {(SINGLE_ENTRY_WIDTH_IN_BITS){1'b0}};
        request_valid_out   <= 1'b0;
    end

    else
    begin
        // write qualified: whether the entry pointed by write_ptr is writable
        if(|write_qualified)
        begin
            write_ptr               <= next_write_ptr;
        end

        else
        begin
            write_ptr               <= write_ptr;
        end

        // read complete: whether the entry pointed by read_ptr has been read (downstream sends back issue_ack_in)
        if(|read_complete)
        begin     
            read_ptr                <= next_read_ptr;
            //request_out             <= {(SINGLE_ENTRY_WIDTH_IN_BITS){1'b0}};
            //request_valid_out       <= 1'b0;
            request_out             <= storage_output;
            request_valid_out       <= fifo_entry_valid[next_read_ptr];
        end

        // hold on the current read
        else if(fifo_entry_valid[read_ptr])
        begin
            read_ptr                <= read_ptr;
            request_out             <= storage_output;
            request_valid_out       <= 1'b1;
        end

        // current read ptr pointed an empty entry, but it's about to be written,
        // use the incoming write for fast output
        else if(~fifo_entry_valid[read_ptr] & write_qualified[read_ptr])
        begin
            request_out             <= request_in;
            request_valid_out       <= 1'b1;
        end

        else
        begin
            read_ptr                <= read_ptr;
            request_out             <= {(SINGLE_ENTRY_WIDTH_IN_BITS){1'b0}};
            request_valid_out       <= 1'b0;
        end
    end
end

// entry valid
generate
genvar gen;

for(gen = 0; gen < QUEUE_SIZE; gen = gen + 1)
begin
    
    reg     entry_valid;
    assign fifo_entry_valid[gen] = entry_valid;

    assign write_qualified[gen] = (~is_full_out | (issue_ack_in & request_valid_out & gen == read_ptr))
                                    & request_valid_in & gen == write_ptr;

    assign read_complete[gen] = ~is_empty_out & issue_ack_in & entry_valid & request_valid_out & gen == read_ptr;

    always @(posedge clk_in or negedge reset_in)
    begin
        if (!reset_in)
        begin
            entry_valid <= 1'b0;
        end

        else
        begin
            if(write_qualified[gen] & read_complete[gen])
            begin
                entry_valid <= 1'b1;
            end

            else
            begin
                if(read_complete[gen])
                begin
                    entry_valid <= 1'b0;
                end

                else if(write_qualified[gen])
                begin
                    entry_valid <= 1'b1;
                end

                else
                begin
                    entry_valid <= entry_valid;
                end
            end
        end
    end
end

    integer queue_index;
    reg [SINGLE_ENTRY_WIDTH_IN_BITS - 1 : 0]    regfile [QUEUE_SIZE - 1 : 0];
    assign storage_output = regfile[|read_complete ? next_read_ptr : read_ptr];
    
    always@(posedge clk_in or negedge reset_in)
    begin
        if(!reset_in)
        begin
            for(queue_index = 0; queue_index < QUEUE_SIZE; queue_index = queue_index + 1)
            begin
                regfile[queue_index] <= 0;
            end
        end

        else
        begin
            if(|write_qualified && |read_complete && write_ptr == read_ptr)
            begin
                regfile[write_ptr] <= request_in;
            end

            else
            begin
                if(|read_complete)
                begin
                    regfile[read_ptr] <= {(SINGLE_ENTRY_WIDTH_IN_BITS){1'b0}};
                end

                if(|write_qualified)
                begin
                    regfile[write_ptr] <= request_in;
                end
            end
        end
    end

endgenerate

endmodule

