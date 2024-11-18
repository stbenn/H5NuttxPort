/****************************************************************************
 * boards/arm/stm32h5/nucleo-h563zi/src/stm32_buttons.c
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.  The
 * ASF licenses this file to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance with the
 * License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
 * License for the specific language governing permissions and limitations
 * under the License.
 *
 ****************************************************************************/

/****************************************************************************
 * Included Files
 ****************************************************************************/

#include <nuttx/config.h>

#include <stdint.h>
#include <stdbool.h>
#include <errno.h>

#include <nuttx/arch.h>
#include <nuttx/board.h>

#include "stm32_gpio.h"
#include "nucleo-h563zi.h"

#include <arch/board/board.h>

#ifdef CONFIG_ARCH_BUTTONS

/****************************************************************************
 * Public Functions
 ****************************************************************************/

/****************************************************************************
 * Name: board_button_initialize
 *
 * Description:
 *   board_button_initialize() must be called to initialize button resources.
 *   After that, board_buttons() may be called to collect the current state
 *   of all buttons or board_button_irq() may be called to register button
 *   interrupt handlers.
 *
 ****************************************************************************/

uint32_t board_button_initialize(void)
{
  /* Configure the single button as an input.  NOTE that EXTI interrupts are
   * also configured for the pin.
   */

  stm32_configgpio(GPIO_BTN_USER);
  return NUM_BUTTONS;
}

/****************************************************************************
 * Name: board_buttons
 ****************************************************************************/

uint32_t board_buttons(void)
{
  /* Check the state of the USER button. */

  return stm32_gpioread(GPIO_BTN_USER) ? BUTTON_USER_BIT : 0;
}

#endif /* CONFIG_ARCH_BUTTONS */
