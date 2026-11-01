#include "Names.h"

#include "Menu.h"

#define NAMES_CODE __attribute__((section(".names")))

static const char Names_entrancePrefixes[3][12] __attribute__((section(".namesData"), used, aligned(4))) =
{
	"ent_",
	"entr_",
	"entrance_",
};

NAMES_CODE const char* Names_skipPrefix(const char* name, const char* prefix)
{
	const char* cursor = name;
	u32 character;
	u32 expected;

	while (*prefix)
	{
		character = (unsigned char)*cursor;
		expected = (unsigned char)*prefix;

		if (character >= 'A' && character <= 'Z')
		{
			character += 'a' - 'A';
		}

		if (character != expected)
		{
			return name;
		}

		++cursor;
		++prefix;
	}

	return cursor;
}

NAMES_CODE const char* Names_entrance(const char* name)
{
	u32 index;
	const char* result;

	PAD_FRAME(2);

	for (index = 0; index < 3; ++index)
	{
		result = Names_skipPrefix(name, Names_entrancePrefixes[index]);

		if (result != name)
		{
			return result;
		}
	}

	return name;
}
