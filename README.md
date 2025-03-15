
# Mastering RTOS: Hands on FreeRTOS and STM32Fx with Debugging (RTOS)

This repo contains notes and programming assignments for the Udemy's "[Mastering RTOS: Hands on FreeRTOS and STM32Fx with Debugging (RTOS)](https://www.udemy.com/course/mastering-rtos-hands-on-with-freertos-arduino-and-stm32fx/)" course by FastBit Embedded Brain Academy.

Date: January, 2024.

- The course is instructed by Engineer Kiran Nayak.

- The [**Certificate**](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Certificate.pdf) is available. 

- The [**SystemView Logs**](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Target_Workspace/records) are available. 

- The [**Coding Exercises**](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/tree/main/Target_Workspace/RTOS_workspace) are available. 

- The [**Output Results**](#exercises-outputs) are available. 

## Descriptions

In this course, we will demystify the complete Architecture (ARM Cortex-M) related code of FreeRTOS and STM32 MCUs.

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
**[Eclipse-based STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)** - C/C++ development platform with peripheral configuration, code generation, code compilation, and debug features for STM32 microcontrollers and microprocessors. Works on Windows/Linux/Mac and is free. \
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


## Exercises Outputs

### 001Tasks:

`001Tasks_001SVdat_with_Preemption`:

![001Tasks_001SVdat_with_Preemption.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/001Tasks_001SVdat_with_Preemption.png)

`001Tasks_002SVdat_without_Preemption`:

![001Tasks_002SVdat_without_Preemption.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/001Tasks_002SVdat_without_Preemption.png)

`001Tasks_003SVdat_with_message`:

![001Tasks_003SVdat_with_message.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/001Tasks_003SVdat_with_message.png)

### 002LED_Tasks:

`002LED_Tasks_004SVdat_with_Preemption`:

![002LED_Tasks_004SVdat_with_Preemption.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/002LED_Tasks_004SVdat_with_Preemption.png)

### 003LED_Block_Tasks:

`003LED_Block_Tasks_005SVdat_with_vTaskDelay`:

![003LED_Block_Tasks_005SVdat_with_vTaskDelay.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/003LED_Block_Tasks_005SVdat_with_vTaskDelay.png)

### 004LED_Periodic_Tasks:

`004LED_Periodic_Tasks_006SVdat_with_vTaskDelayUntil`:

![004LED_Periodic_Tasks_006SVdat_with_vTaskDelayUntil.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/004LED_Periodic_Tasks_006SVdat_with_vTaskDelayUntil.png)

### 005LED_Task_Notify:

`005LED_Task_Notify_007SVdat_with_xTaskNotifyWait_vTaskDelete`:

![005LED_Task_Notify_007SVdat_with_xTaskNotifyWait_vTaskDelete.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/005LED_Task_Notify_007SVdat_with_xTaskNotifyWait_vTaskDelete.png)

### 006LED_Btn_ISR:

`006LED_Btn_ISR_008SVdat_with_xTaskNotifyFromISR_vportYIELD_FROM_ISR`:

![006LED_Btn_ISR_008SVdat_with_xTaskNotifyFromISR_vportYIELD_FROM_ISR.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/006LED_Btn_ISR_008SVdat_with_xTaskNotifyFromISR_vportYIELD_FROM_ISR.png)

### 007Task_Priority:

`007Task_Priority_009SVdat_with_vTaskPrioritySet`:

![007Task_Priority_009SVdat_with_vTaskPrioritySet.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/007Task_Priority_009SVdat_with_vTaskPrioritySet.png)

### 008Queues_n_timers:

`008Queues_n_timers`:

![008Queues_n_timers.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/008Queues_n_timers.png)

`008Queues_n_timers_SWV`:

![008Queues_n_timers_SWV.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/008Queues_n_timers_SWV.png)

### 009Bin_Semaphore_Tasks:

`009Bin_Semaphore_Tasks`:

![009Bin_Semaphore_Tasks.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/009Bin_Semaphore_Tasks.png)

### 010Cnt_Semaphore_Tasks:

`010Cnt_Semaphore_Tasks`:

![010Cnt_Semaphore_Tasks.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/010Cnt_Semaphore_Tasks.png)

### 011Mutex_using_Bin_Sema:

`011Mutex_using_Bin_Sema`:

![011Mutex_using_Bin_Sema.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/011Mutex_using_Bin_Sema.png)

### 012MutexAPI:

`012MutexAPI_without_Mutex`:

![012MutexAPI_without_Mutex.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/012MutexAPI_without_Mutex.png)

`012MutexAPI_with_Mutex`:

![012MutexAPI_with_Mutex.png](https://github.com/renatosoriano/Udemy-Embedded-Course7_Mastering-RTOS-Hands-on-FreeRTOS-and-STM32Fx-with-Debugging/blob/main/Images/012MutexAPI_with_Mutex.png)


