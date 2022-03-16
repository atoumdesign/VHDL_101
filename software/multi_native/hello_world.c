#include <stdio.h>
#include <io.h>
#include <system.h>
#include <altera_avalon_performance_counter.h>

int main(){
	PERF_RESET(PERFORMANCE_COUNTER_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_BASE);
	PERF_BEGIN(PERFORMANCE_COUNTER_BASE, 1);
	unsigned int a = 2;
	unsigned int p = 3;

	unsigned int output = 0;

	printf("Multiplicador com acelerador (*)\n");

	IOWR(MULTI_NATIVE_0_BASE, 0, a);
	IOWR(MULTI_NATIVE_0_BASE, 0, p);

	while((output = IORD(MULTI_NATIVE_0_BASE, 0)) < 128);
	PERF_END(PERFORMANCE_COUNTER_BASE, 1);
	printf("Resultado: %u\n", ((int)output & 127));

	PERF_STOP_MEASURING(PERFORMANCE_COUNTER_BASE);
	perf_print_formatted_report((void*) PERFORMANCE_COUNTER_BASE,ALT_CPU_FREQ, 1, "total");
	return 0;
}
