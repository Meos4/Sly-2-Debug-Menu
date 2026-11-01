#ifndef SLY_NTSC_U_WORLDS_H
#define SLY_NTSC_U_WORLDS_H

#include "Common/Types.h"

typedef struct
{
	u32 fid;
	char name[48];
	u32 size;
	u32 lba;
	u32 reserved;
} NtscUWorlds_Descriptor;

#endif
