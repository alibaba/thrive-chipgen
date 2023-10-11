#ifndef DSA_H
#define DSA_H
#endif

#include "xocc_asm.h"
#include "qid.h"

// [TODO] Currently, Only support homogeneous auto-generation

/*
 * dispatcher -> regular_0
 */
static inline void dispatcher_push_regular_0_cmd(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_0_QID_0));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_0_QID_0)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_0_QID_0));
}

static inline void dispatcher_pop_regular_0_rsp(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_0_QID_0));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_0_QID_0));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_0_QID_0));
}

/*
 * dispatcher -> regular_1
 */
static inline void dispatcher_push_regular_1_cmd(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_0_QID_1));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_0_QID_1)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_0_QID_1));
}

static inline void dispatcher_pop_regular_1_rsp(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_0_QID_1));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_0_QID_1));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_0_QID_1));
}

/*
 * dispatcher -> nou
 */
static inline void dispatcher_push_nou_cmd(unsigned int w0, unsigned int w1){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_0_QID_2));
    FUNC_WRITE_CMD(result, w1, IMM12(01, RV_0_QID_2));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_0_QID_2)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_0_QID_2));
}

static inline void dispatcher_pop_nou_rsp(unsigned int *w0, unsigned int *w1){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_0_QID_2));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_0_QID_2));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_0_QID_2));
    FUNC_READ_RSP(*w1, result, IMM12(01, RV_0_QID_2));
}

/*
 * dispatcher -> dsa_2
 */
static inline void dispatcher_push_dsa_2_cmd(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_0_QID_3));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_0_QID_3)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_0_QID_3));
}

static inline void dispatcher_pop_dsa_2_rsp(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_0_QID_3));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_0_QID_3));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_0_QID_3));
}

/*
 * regular_0 -> dispatcher
 */
static inline void regular_0_push_dispatcher_cmd(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_1_QID_0));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_1_QID_0)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_1_QID_0));
}

static inline void regular_0_pop_dispatcher_rsp(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_1_QID_0));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_1_QID_0));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_1_QID_0));
}

/*
 * regular_0 -> dsa_0
 */
static inline void regular_0_push_dsa_0_cmd(unsigned int w0, unsigned int w1, unsigned int w2){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_1_QID_1));
    FUNC_WRITE_CMD(result, w1, IMM12(01, RV_1_QID_1));
    FUNC_WRITE_CMD(result, w2, IMM12(02, RV_1_QID_1));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_1_QID_1)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_1_QID_1));
}

static inline void regular_0_pop_dsa_0_rsp(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_1_QID_1));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_1_QID_1));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_1_QID_1));
}

/*
 * regular_1 -> dispatcher
 */
static inline void regular_1_push_dispatcher_cmd(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_2_QID_0));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_2_QID_0)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_2_QID_0));
}

static inline void regular_1_pop_dispatcher_rsp(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_2_QID_0));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_2_QID_0));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_2_QID_0));
}

/*
 * regular_1 -> dsa_1
 */
static inline void regular_1_push_dsa_1_cmd(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, RV_2_QID_1));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, RV_2_QID_1)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, RV_2_QID_1));
}

static inline void regular_1_pop_dsa_1_rsp(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, RV_2_QID_1));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, RV_2_QID_1));
    FUNC_READ_RSP(*w0, result, IMM12(00, RV_2_QID_1));
}

