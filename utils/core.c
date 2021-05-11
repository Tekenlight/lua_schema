#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

void free_binary_data(unsigned char *data)
{
	unsigned char *address = data - sizeof(size_t);
	//printf("%s:%d, Freeing %p:%p, size[%lu]\n", __FILE__, __LINE__, (void*) address, (void*)data, sizeof(size_t));
	free(address);
}

size_t binary_data_len(unsigned char *data)
{
	size_t size;
	memcpy(&size, (unsigned char *)data - sizeof(size_t), sizeof(size_t));
	return size;
}

