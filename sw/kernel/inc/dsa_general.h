//////////////////////////////////////////////////////////////////////////////
// Author: Zhe Zhang
// 
// General XoCC API: Can be used for heterogenous kernel development
// push API: push_{cmd_len}_{qid}
// pop API: pop_{cmd_len}_{qid}
//
//////////////////////////////////////////////////////////////////////////////

#include "xocc_asm.h"

/*
 * Push
 */
static inline void push_32_0(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 0));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 0)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 0));
}

static inline void push_32_1(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 1));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 1)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 1));
}

static inline void push_32_2(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 2));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 2)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 2));
}

static inline void push_32_3(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 3));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 3)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 3));
}

static inline void push_32_4(unsigned int w0){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 4));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 4)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 4));
}

static inline void push_64_0(unsigned int w0, unsigned int w1){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 0));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 0));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 0)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 0));
}

static inline void push_64_1(unsigned int w0, unsigned int w1){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 1));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 1));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 1)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 1));
}

static inline void push_64_2(unsigned int w0, unsigned int w1){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 2));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 2));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 2)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 2));
}

static inline void push_64_3(unsigned int w0, unsigned int w1){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 3));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 3));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 3)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 3));
}

static inline void push_64_4(unsigned int w0, unsigned int w1){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 4));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 4));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 4)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 4));
}

static inline void push_96_0(unsigned int w0, unsigned int w1, unsigned int w2){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 0));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 0));
    FUNC_WRITE_CMD(result, w2, IMM12(02, 0));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 0)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 0));
}

static inline void push_96_1(unsigned int w0, unsigned int w1, unsigned int w2){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 1));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 1));
    FUNC_WRITE_CMD(result, w2, IMM12(02, 1));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 1)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 1));
}

static inline void push_96_2(unsigned int w0, unsigned int w1, unsigned int w2){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 2));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 2));
    FUNC_WRITE_CMD(result, w2, IMM12(02, 2));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 2)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 2));
}

static inline void push_96_3(unsigned int w0, unsigned int w1, unsigned int w2){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 3));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 3));
    FUNC_WRITE_CMD(result, w2, IMM12(02, 3));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 3)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 3));
}

static inline void push_96_4(unsigned int w0, unsigned int w1, unsigned int w2){
    unsigned int result;
    unsigned int ready = 0;
    FUNC_WRITE_CMD(result, w0, IMM12(00, 4));
    FUNC_WRITE_CMD(result, w1, IMM12(01, 4));
    FUNC_WRITE_CMD(result, w2, IMM12(02, 4));
    do { 
        FUNC_PUSH_RDY(ready, 0, IMM12(00, 4)); 
    } while (!ready); 
    FUNC_PUSH_CMD(result, 0, IMM12(00, 4));
}

/*
 * Pop
 */
static inline void pop_32_0(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 0));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 0));
    FUNC_READ_RSP(*w0, result, IMM12(00, 0));
}

static inline void pop_32_1(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 1));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 1));
    FUNC_READ_RSP(*w0, result, IMM12(00, 1));
}

static inline void pop_32_2(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 2));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 2));
    FUNC_READ_RSP(*w0, result, IMM12(00, 2));
}

static inline void pop_32_3(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 3));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 3));
    FUNC_READ_RSP(*w0, result, IMM12(00, 3));
}

static inline void pop_32_4(unsigned int *w0){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 4));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 4));
    FUNC_READ_RSP(*w0, result, IMM12(00, 4));
}

static inline void pop_64_0(unsigned int *w0, unsigned int *w1){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 0));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 0));
    FUNC_READ_RSP(*w0, result, IMM12(00, 0));
    FUNC_READ_RSP(*w1, result, IMM12(01, 0));
}

static inline void pop_64_1(unsigned int *w0, unsigned int *w1){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 1));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 1));
    FUNC_READ_RSP(*w0, result, IMM12(00, 1));
    FUNC_READ_RSP(*w1, result, IMM12(01, 1));
}

static inline void pop_64_2(unsigned int *w0, unsigned int *w1){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 2));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 2));
    FUNC_READ_RSP(*w0, result, IMM12(00, 2));
    FUNC_READ_RSP(*w1, result, IMM12(01, 2));
}

static inline void pop_64_3(unsigned int *w0, unsigned int *w1){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 3));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 3));
    FUNC_READ_RSP(*w0, result, IMM12(00, 3));
    FUNC_READ_RSP(*w1, result, IMM12(01, 3));
}

static inline void pop_64_4(unsigned int *w0, unsigned int *w1){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 4));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 4));
    FUNC_READ_RSP(*w0, result, IMM12(00, 4));
    FUNC_READ_RSP(*w1, result, IMM12(01, 4));
}

static inline void pop_96_0(unsigned int *w0, unsigned int *w1, unsigned int *w2){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 0));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 0));
    FUNC_READ_RSP(*w0, result, IMM12(00, 0));
    FUNC_READ_RSP(*w1, result, IMM12(01, 0));
    FUNC_READ_RSP(*w2, result, IMM12(02, 0));
}

static inline void pop_96_1(unsigned int *w0, unsigned int *w1, unsigned int *w2){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 1));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 1));
    FUNC_READ_RSP(*w0, result, IMM12(00, 1));
    FUNC_READ_RSP(*w1, result, IMM12(01, 1));
    FUNC_READ_RSP(*w2, result, IMM12(02, 1));
}

static inline void pop_96_2(unsigned int *w0, unsigned int *w1, unsigned int *w2){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 2));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 2));
    FUNC_READ_RSP(*w0, result, IMM12(00, 2));
    FUNC_READ_RSP(*w1, result, IMM12(01, 2));
    FUNC_READ_RSP(*w2, result, IMM12(02, 2));
}

static inline void pop_96_3(unsigned int *w0, unsigned int *w1, unsigned int *w2){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 3));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 3));
    FUNC_READ_RSP(*w0, result, IMM12(00, 3));
    FUNC_READ_RSP(*w1, result, IMM12(01, 3));
    FUNC_READ_RSP(*w2, result, IMM12(02, 3));
}

static inline void pop_96_4(unsigned int *w0, unsigned int *w1, unsigned int *w2){
    unsigned int result;
    unsigned int ready = 0;
    do {
        FUNC_POP_RDY(ready, 0, IMM12(00, 4));
    } while (!ready);
    FUNC_POP_RSP(result, 0, IMM12(00, 4));
    FUNC_READ_RSP(*w0, result, IMM12(00, 4));
    FUNC_READ_RSP(*w1, result, IMM12(01, 4));
    FUNC_READ_RSP(*w2, result, IMM12(02, 4));
}

