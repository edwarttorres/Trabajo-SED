/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

void HAL_TIM_MspPostInit(TIM_HandleTypeDef *htim);

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define Fusible_Casa_Pin GPIO_PIN_0
#define Fusible_Casa_GPIO_Port GPIOA
#define Fusible_Casa_EXTI_IRQn EXTI0_IRQn
#define Sensor_LDR_Pin GPIO_PIN_1
#define Sensor_LDR_GPIO_Port GPIOA
#define SW_Manual_Pin GPIO_PIN_2
#define SW_Manual_GPIO_Port GPIOA
#define SW_Manual_EXTI_IRQn EXTI2_IRQn
#define Led_s_Jardin_Pin GPIO_PIN_14
#define Led_s_Jardin_GPIO_Port GPIOB
#define Led_s_WC_Pin GPIO_PIN_15
#define Led_s_WC_GPIO_Port GPIOB
#define Led_s_Habit1_Pin GPIO_PIN_9
#define Led_s_Habit1_GPIO_Port GPIOD
#define Led_s_Salon_Pin GPIO_PIN_10
#define Led_s_Salon_GPIO_Port GPIOD
#define Led_s_Cocina_Pin GPIO_PIN_11
#define Led_s_Cocina_GPIO_Port GPIOD
#define LED_Naranja_Pin GPIO_PIN_13
#define LED_Naranja_GPIO_Port GPIOD
#define LED_Rojo_Pin GPIO_PIN_14
#define LED_Rojo_GPIO_Port GPIOD
#define LED_Azul_Pin GPIO_PIN_15
#define LED_Azul_GPIO_Port GPIOD
#define SW_Jardin_MINI_Pin GPIO_PIN_6
#define SW_Jardin_MINI_GPIO_Port GPIOC
#define SW_Hab_N_Pin GPIO_PIN_7
#define SW_Hab_N_GPIO_Port GPIOC
#define SW_WC_R_Pin GPIO_PIN_9
#define SW_WC_R_GPIO_Port GPIOC
#define RGB_Rojo_Pin GPIO_PIN_8
#define RGB_Rojo_GPIO_Port GPIOA
#define RGB_Verde_Pin GPIO_PIN_9
#define RGB_Verde_GPIO_Port GPIOA
#define RGB_Azul_Pin GPIO_PIN_10
#define RGB_Azul_GPIO_Port GPIOA
#define SW_Salon_AMA_Pin GPIO_PIN_10
#define SW_Salon_AMA_GPIO_Port GPIOC
#define SW_Cocina_A_Pin GPIO_PIN_11
#define SW_Cocina_A_GPIO_Port GPIOC
#define SW_Automatico_Pin GPIO_PIN_12
#define SW_Automatico_GPIO_Port GPIOC
#define SW_Automatico_EXTI_IRQn EXTI15_10_IRQn
#define Echo_Pin GPIO_PIN_3
#define Echo_GPIO_Port GPIOD
#define Trigger_Pin GPIO_PIN_4
#define Trigger_GPIO_Port GPIOD
#define SW_RGB_Pin GPIO_PIN_1
#define SW_RGB_GPIO_Port GPIOE
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
