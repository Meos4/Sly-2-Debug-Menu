#ifndef SLY_PAYLOAD_H
#define SLY_PAYLOAD_H

#include "Common/Types.h"

typedef struct
{
	u32 address;
	u32 count;
	u32 stride;
	u32 value;
} Payload_Initializer;

#endif
