return {
	s({ trig = "main", snippetType = "snippet", desc = "create a standard main" }, {
		t({
			"#include <stdio.h>",
			"",
			"int	main([[maybe_unused]] int ac, [[maybe_unused]] char **av) {",
			'	printf("Hello, World!\\n");',
			"",
			"	return 0;",
			"}",
		}),
	}),
}
