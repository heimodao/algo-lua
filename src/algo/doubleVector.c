#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include "doubleVector.h"

char dtoa(int d) {
  if (d == 0) {
    return '0';
  } else if (d == 1) {
    return '1';
  } else if (d == 2) {
    return '2';
  } else if (d == 3) {
    return '3';
  } else if (d == 4) {
    return '4';
  } else if (d == 5) {
    return '5';
  } else if (d == 6) {
    return '6';
  } else if (d == 7) {
    return '7';
  } else if (d == 8) {
    return '8';
  } else if (d == 9) {
    return '9';
  } else {
    return 'x';
  }
}

char* utoa(size_t s) {
  size_t d = 0;
  size_t temp = s;
  while (temp > 0) {
    temp = temp / 10;
    d = d + 1;

  }

  char* str = malloc((d + 1) * sizeof(char));

  temp = s;
  int i = d;
  while (temp > 0) {
    int n = temp % 10;
    char c = dtoa(n);
    str[i - 1] = c;
    temp = temp / 10;
    i = i - 1;
  }
  str[d] = '\0';

  return str;
}

void* double_vector_new(size_t s) {
  DoubleVector* vector = malloc(sizeof(DoubleVector));
  vector->size = s;
  vector->vec = malloc(vector->size * sizeof(double));

  for (int i = 0; i < vector->size; i++) {
    vector->vec[i] = 0.0;
  }

  return (void*) vector;
}

size_t double_vector_size(void* v) {
  return ((DoubleVector*) v)->size;
}

double double_vector_get(void* v, size_t index) {
  if (index > ((DoubleVector*) v)->size - 1) {
    double_vector_error(v, "Index out of range\n");
  }

  return ((DoubleVector*) v)->vec[index];
}

void double_vector_set(void* v, size_t index, double data) {
  if (index > ((DoubleVector*) v)->size - 1) {
    double_vector_error(v, "Index out of range\n");
  }

  ((DoubleVector*) v)->vec[index] = data;
}

int double_vector_equal(void* v1, void* v2) {
  if (((DoubleVector*) v1)->size != ((DoubleVector*) v2)->size) {
    return 0;
  }

  size_t len = ((DoubleVector*) v1)->size;
  for (int i = 0; i < len; i++) {
    if (((DoubleVector*) v1)->vec[i] != ((DoubleVector*) v2)->vec[i]) {
      return 0;
    }
  }

  return 1;
}

void double_vector_error(void* v, const char* msg) {
  fprintf(stderr, "%s", msg);
  double_vector_free(v);
  exit(EXIT_FAILURE);
}

void double_vector_free(void* v) {
  free((void*) ((DoubleVector*) v)->vec);
  free((void*) v);
}