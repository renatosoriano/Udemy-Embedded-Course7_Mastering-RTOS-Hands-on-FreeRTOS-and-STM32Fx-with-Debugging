################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/SEGGER/Config/SEGGER_SYSVIEW_Config_FreeRTOS.c 

OBJS += \
./ThirdParty/SEGGER/Config/SEGGER_SYSVIEW_Config_FreeRTOS.o 

C_DEPS += \
./ThirdParty/SEGGER/Config/SEGGER_SYSVIEW_Config_FreeRTOS.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/SEGGER/Config/%.o ThirdParty/SEGGER/Config/%.su: ../ThirdParty/SEGGER/Config/%.c ThirdParty/SEGGER/Config/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F446xx -c -I../Core/Inc -I"/Users/renatosoriano/FastBit_Embedded_Courses_Udemy/Course7_Workspace/Target_Workspace/RTOS_workspace/001Tasks/ThirdParty/SEGGER/Config" -I"/Users/renatosoriano/FastBit_Embedded_Courses_Udemy/Course7_Workspace/Target_Workspace/RTOS_workspace/001Tasks/ThirdParty/SEGGER/OS" -I"/Users/renatosoriano/FastBit_Embedded_Courses_Udemy/Course7_Workspace/Target_Workspace/RTOS_workspace/001Tasks/ThirdParty/SEGGER/SEGGER" -I"/Users/renatosoriano/FastBit_Embedded_Courses_Udemy/Course7_Workspace/Target_Workspace/RTOS_workspace/001Tasks/ThirdParty/FreeRTOS" -I"/Users/renatosoriano/FastBit_Embedded_Courses_Udemy/Course7_Workspace/Target_Workspace/RTOS_workspace/001Tasks/ThirdParty/FreeRTOS/include" -I"/Users/renatosoriano/FastBit_Embedded_Courses_Udemy/Course7_Workspace/Target_Workspace/RTOS_workspace/001Tasks/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-SEGGER-2f-Config

clean-ThirdParty-2f-SEGGER-2f-Config:
	-$(RM) ./ThirdParty/SEGGER/Config/SEGGER_SYSVIEW_Config_FreeRTOS.d ./ThirdParty/SEGGER/Config/SEGGER_SYSVIEW_Config_FreeRTOS.o ./ThirdParty/SEGGER/Config/SEGGER_SYSVIEW_Config_FreeRTOS.su

.PHONY: clean-ThirdParty-2f-SEGGER-2f-Config

