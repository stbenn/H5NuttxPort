# Tracking Ethernet Driver Port for H5

The H5 ethernet peripheral IP is nearly identical to the H7, so will pull from that driver.

The user manual shows the only register differences are default/reset values,
and version registers.
- Except for `ETH_MAC1USTCR` but that is a timing register that must get set
  by software initially anyways. 

## H7 Driver Notes
The H7 ethernet driver `arch/arm/stm32h7/stm32_ethernet.c` relies on these
architecture specific files:
- `hardware/stm32_syscfg.h`
- `hardware/stm32_pinmap.h`
- `stm32_gpio.h`
- `stm32_rcc.h`
- `stm32_uid.h`

There are a couple of differences between our internal H7 driver and the one
on apache. Need to investigate those to see the effects. 


## Plan of action
I think a good place to start is going to be getting the hardware files
prepared, and making sure the headers are correct. 

Q: At what point should the KConfig be worked on? 
A: I think the first thing should actually be to add the KConfig options.

### Adding ethernet to Kconfig
On the H7, the "Ethernet MAC configuration" menu is hidden unless the
peripheral is enabled in the peripheral selection (Peripheral Support on H5)

Adding STM32_STM32H5X3XX to the config because ethernet is ONLY supported on 
STM32H563/573 devices. 