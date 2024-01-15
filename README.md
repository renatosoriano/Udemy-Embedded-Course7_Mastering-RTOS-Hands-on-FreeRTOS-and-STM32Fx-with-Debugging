
# Mastering RTOS: Hands on FreeRTOS and STM32Fx with Debugging (RTOS)

This repo contains notes and programming assignments for the Udemy's "[Mastering RTOS: Hands on FreeRTOS and STM32Fx with Debugging (RTOS)](https://www.udemy.com/course/mastering-rtos-hands-on-with-freertos-arduino-and-stm32fx/)" course by FastBit Embedded Brain Academy.

Date: January, 2024.

- The course is instructed by Engineer Kiran Nayak.

- The [**Certificate**](https://github.com/renatosoriano/) is available. 

- The [**SystemView Logs**](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Target_Workspace/records) are available. 

- The [**Output Results**](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Target_Workspace) are available. 

## Descriptions

In this course, we will demystify the complete Architecture (ARM Cortex M) related code of FreeRTOS and STM32 MCUs.

The course covers:
1. Understanding various RTOS concepts with FreeRTOS Programming and Debugging.
2. Important scheduling policies of FreeRTOS Scheduler.
3. Implementing mutual exclusion between Tasks using Mutex services and semaphores.
4. Understanding Architecture specific codes like SVC_handler, PendSV_handler, SysTick Handler line by line.
5. Understanding complete ARM Cortex M and FreeRTOS Priority model and its configuration related informations.
6. FreeRTOS Task Creation , Deletion, Scheduling.
7. FreeRTOS Stack and Heap Management.
8. FreeRTOS Queue management like creation, sending, receiving, and blocking.
9. Understanding Context Switching with in detail code explanation.
10. Kernel Tick timer, frequency and its configuration details.
11. FreeRTOS Debugging using SEGGER SystemView Software.
12. Debugging with SEGGER software toolkit by taking snapshot and continuous mode recording.

## Requirements

**[STM32 Nucleo-F446RE Development Board](https://www.st.com/en/evaluation-tools/nucleo-f446re.html#overview)** - Board used in this course but any board with Arm Cortex-M0/3/4 core will work, just modifying the target board and configuring with the respective datasheet. \
**[Eclipse-based STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)** - C/C++ development platform with peripheral configuration, code generation, code compilation, and debug features for STM32 microcontrollers and microprocessors. Works on Windows/Linux/Mac and is free.
**[SEGGER SystemView](https://www.segger.com/products/development-tools/systemview/)** - Real-time recording and visualization tool for embedded systems. It reveals the true runtime behavior of an application, going far deeper than the system insights provided by debuggers. This is particularly effective when developing and working with complex embedded systems comprising multiple threads and interrupts. Works on Windows/Linux/Mac and is free.

## Notes
* #### FPU warning fix
    Right click on the project -> properties -> expand C/C++ build -> Settings -> Tool settings -> MCU settings
  * `Floating-point unit: None`
  * `Floating-point ABI: Software implementation ( -mfloat-abi=soft )`

![FPU_warning.png](https://github.com/renatosoriano/Udemy-Embedded-Course5_Mastering-Microcontroller-STM32-LTDC-LCD-TFT-LVGL-MCU3/blob/main/Images/FPU_warning.png)

* #### Setting up SWV ITM Data Console

Open *syscalls.c* file and paste following code bellow *Includes*

```c
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//           Implementation of printf like feature using ARM Cortex M3/M4/ ITM functionality
//           This function will not work for ARM Cortex M0/M0+
//           If you are using Cortex M0, then you can use semihosting feature of openOCD
/////////////////////////////////////////////////////////////////////////////////////////////////////////


//Debug Exception and Monitor Control Register base address
#define DEMCR                   *((volatile uint32_t*) 0xE000EDFCU )

/* ITM register addresses */
#define ITM_STIMULUS_PORT0   	*((volatile uint32_t*) 0xE0000000 )
#define ITM_TRACE_EN          	*((volatile uint32_t*) 0xE0000E00 )

void ITM_SendChar(uint8_t ch)
{

	//Enable TRCENA
	DEMCR |= ( 1 << 24);

	//enable stimulus port 0
	ITM_TRACE_EN |= ( 1 << 0);

	// read FIFO status in bit [0]:
	while(!(ITM_STIMULUS_PORT0 & 1));

	//Write to ITM stimulus port0
	ITM_STIMULUS_PORT0 = ch;
}
```


After that find function *_write* and replace `__io_putchar(*ptr++)` with `ITM_SendChar(*ptr++)` like in code snippet below
```c
__attribute__((weak)) int _write(int file, char *ptr, int len)
{
	int DataIdx;

	for (DataIdx = 0; DataIdx < len; DataIdx++)
	{
		//__io_putchar(*ptr++);
		ITM_SendChar(*ptr++);
	}
	return len;
}
```

After these steps navigate to Debug configuration and check `Serial Wire Viewer (SWV)` check box like on snapshot below

![Debugger.png](https://github.com/renatosoriano/Udemy-Embedded-Course5_Mastering-Microcontroller-STM32-LTDC-LCD-TFT-LVGL-MCU3/blob/main/Images/Debugger.png)

Once you enter *Debug* mode, go to `Window -> Show View -> SWV -> Select SWV ITM Data Console`. On this way `ITM Data Console` will be shown in *Debug* session.


In `SWV ITM Data Console Settings` in section `ITM Stimulus Ports` enable port 0, so that you can see `printf` data.



