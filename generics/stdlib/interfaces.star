# GlobalGround = Net("GND")

Ground = interface(
    net=Net("GND", type="ground"),
)

Power = interface(
    net=Net("VCC", type="power"),
)

OscPair = interface(
    xin=Net,
    xout=Net,
)

Uart = interface(
    tx=Net,
    rx=Net,
)

CanTtl = interface(
    tx=Net,
    rx=Net,
)

Can = interface(
    can_h=Net,
    can_l=Net,
)


def UartPair(name_a: str, name_b: str) -> (Uart, Uart):
    txa_rxb = Net(name_a + "_TX/" + name_b + "_RX")
    rxa_txb = Net(name_a + "_RX/" + name_b + "_TX")
    uart_a = Uart(name=name_a, tx=txa_rxb, rx=rxa_txb)
    uart_b = Uart(name=name_b, tx=rxa_txb, rx=txa_rxb)
    return (uart_a, uart_b)


Spi = interface(
    cs=Net,
    miso=Net,
    mosi=Net,
    clk=Net,
)

Qspi = interface(
    cs=Net,
    clk=Net,
    io0=Net,
    io1=Net,
    io2=Net,
    io3=Net,
)

DiffPair = interface(
    p=Net,
    n=Net,
)

Swd = interface(
    swdio=Net,
    swclk=Net,
)

Swd10Pin = interface(
    uart=Uart,
    swd=Swd,
)

I2c = interface(
    sda=Net,
    scl=Net,
)

Usb2 = interface(
    dp=Net,
    dm=Net,
)

Usb3 = interface(
    dp=Net,
    dm=Net,
    ss_tx_n=Net,
    ss_tx_p=Net,
    ss_rx_n=Net,
    ss_rx_p=Net,
)

Gpio = interface(
    net=Net,
)

Pwm = interface(
    net=Net,
)

PwmPair = interface(
    a=Net,
    b=Net,
)

Analog = interface(
    net=Net,
)
