load(
    "../../interfaces.star",
    "Analog",
    "Ground",
    "I2c",
    "OscPair",
    "Power",
    "PwmPair",
    "Qspi",
    "Spi",
    "Swd",
    "Uart",
    "Usb2",
)
load(
    "../../pins.star",
    "PinInterface",
    "PinMapBuilder",
    "Pins",
)

def PinMap(pins: Pins = {}):
    """RP2040 Pin Map

    Args:
        pins: Pins to assign to the pin map.

    Returns:
        Pin map.
    """

    OSC = PinInterface("OSC", OscPair)
    USB = PinInterface("USB", Usb2)
    QSPI = PinInterface("QSPI", Qspi)
    SWD = PinInterface("SWD", Swd)
    I2C0 = PinInterface("I2C0", I2c)
    I2C1 = PinInterface("I2C1", I2c)
    UART0 = PinInterface("UART0", Uart)
    UART1 = PinInterface("UART1", Uart)
    SPI0 = PinInterface("SPI0", Spi)
    SPI1 = PinInterface("SPI1", Spi)
    PWM0 = PinInterface("PWM0", PwmPair)
    PWM1 = PinInterface("PWM1", PwmPair)
    PWM2 = PinInterface("PWM2", PwmPair)
    PWM3 = PinInterface("PWM3", PwmPair)
    PWM4 = PinInterface("PWM4", PwmPair)
    PWM5 = PinInterface("PWM5", PwmPair)
    PWM6 = PinInterface("PWM6", PwmPair)
    PWM7 = PinInterface("PWM7", PwmPair)
    ADC0 = PinInterface("ADC0", Analog)
    ADC1 = PinInterface("ADC1", Analog)
    ADC2 = PinInterface("ADC2", Analog)
    ADC3 = PinInterface("ADC3", Analog)

    return PinMapBuilder(
        pin_nets = pins,
        pin_map = {
            "XIN": [OSC.XIN],
            "XOUT": [OSC.XOUT],
            "USB_DP": [USB.DP],
            "USB_DM": [USB.DM],
            "QSPI_SS_N": [QSPI.CS],
            "QSPI_SCLK": [QSPI.CLK],
            "QSPI_SD0": [QSPI.IO0],
            "QSPI_SD1": [QSPI.IO1],
            "QSPI_SD2": [QSPI.IO2],
            "QSPI_SD3": [QSPI.IO3],
            "SWDIO": [SWD.SWDIO],
            "SWCLK": [SWD.SWCLK],
            "GPIO0": [I2C0.SDA, UART0.TX, SPI0.MISO, PWM0.A],
            "GPIO1": [I2C0.SCL, UART0.RX, SPI0.CS, PWM0.B],
            "GPIO2": [I2C1.SDA, SPI0.CLK, PWM1.A],
            "GPIO3": [I2C1.SCL, SPI0.MOSI, PWM1.B],
            "GPIO4": [I2C0.SDA, UART1.TX, SPI0.MISO, PWM2.A],
            "GPIO5": [I2C0.SCL, UART1.RX, SPI0.CS, PWM2.B],
            "GPIO6": [I2C1.SDA, SPI0.CLK, PWM3.A],
            "GPIO7": [I2C1.SCL, SPI0.MOSI, PWM3.B],
            "GPIO8": [I2C0.SDA, UART1.TX, SPI1.MISO, PWM4.A],
            "GPIO9": [I2C0.SCL, UART1.RX, SPI1.CS, PWM4.B],
            "GPIO10": [I2C1.SDA, SPI1.CLK, PWM5.A],
            "GPIO11": [I2C1.SCL, SPI1.MOSI, PWM5.B],
            "GPIO12": [I2C0.SDA, UART0.TX, SPI1.MISO, PWM6.A],
            "GPIO13": [I2C0.SCL, UART0.RX, SPI1.CS, PWM6.B],
            "GPIO14": [I2C1.SDA, SPI1.CLK, PWM7.A],
            "GPIO15": [I2C1.SCL, SPI1.MOSI, PWM7.B],
            "GPIO16": [I2C0.SDA, UART0.TX, SPI0.MISO, PWM0.A],
            "GPIO17": [I2C0.SCL, UART0.RX, SPI0.CS, PWM0.B],
            "GPIO18": [I2C1.SDA, SPI0.CLK, PWM1.A],
            "GPIO19": [I2C1.SCL, SPI0.MOSI, PWM1.B],
            "GPIO20": [I2C0.SDA, UART1.TX, SPI0.MISO, PWM2.A],
            "GPIO21": [I2C0.SCL, UART1.RX, SPI0.CS, PWM2.B],
            "GPIO22": [I2C1.SDA, SPI0.CLK, PWM3.A],
            "GPIO23": [I2C1.SCL, SPI0.MOSI, PWM3.B],
            "GPIO24": [I2C0.SDA, UART1.TX, SPI1.MISO, PWM4.A],
            "GPIO25": [I2C0.SCL, UART1.RX, SPI1.CS, PWM4.B],
            "GPIO26/ADC0": [I2C1.SDA, SPI1.CLK, PWM5.A, ADC0.NET],
            "GPIO27/ADC1": [I2C1.SCL, SPI1.MOSI, PWM5.B, ADC1.NET],
            "GPIO28/ADC2": [I2C0.SDA, UART0.TX, SPI1.MISO, PWM6.A, ADC2.NET],
            "GPIO29/ADC3": [I2C0.SCL, UART0.RX, SPI1.CS, PWM6.B, ADC3.NET],
        },
    )

GPIO1 = Net("GPIO1")
i2c0 = I2c("I2C0")

pins = PinMap().connect("GPIO1", GPIO1).assign("I2C0", i2c0, SCL = "GPIO5", SDA = "GPIO4").build()
