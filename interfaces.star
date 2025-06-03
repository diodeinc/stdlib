Ground = interface(
    NET=Net("GND", type="ground"),
)

Power = interface(
    NET=Net("VCC", type="power"),
)

OscPair = interface(
    XIN=Net,
    XOUT=Net,
)

Uart = interface(
    TX=Net,
    RX=Net,
)

CanTtl = interface(
    TX=Net,
    RX=Net,
)

Can = interface(
    CAN_H=Net,
    CAN_L=Net,
)


def UartPair(name_a: str, name_b: str) -> (Uart, Uart):
    txa_rxb = Net(name_a + "_TX/" + name_b + "_RX")
    rxa_txb = Net(name_a + "_RX/" + name_b + "_TX")
    uart_a = Uart(name=name_a, tx=txa_rxb, rx=rxa_txb)
    uart_b = Uart(name=name_b, tx=rxa_txb, rx=txa_rxb)
    return (uart_a, uart_b)


Spi = interface(
    CS=Net,
    MISO=Net,
    MOSI=Net,
    CLK=Net,
)

Qspi = interface(
    CS=Net,
    CLK=Net,
    IO0=Net,
    IO1=Net,
    IO2=Net,
    IO3=Net,
)

DiffPair = interface(
    P=Net,
    N=Net,
)

Swd = interface(
    SWDIO=Net,
    SWCLK=Net,
)

Swd10Pin = interface(
    uart=Uart,
    swd=Swd,
)

I2c = interface(
    SDA=Net,
    SCL=Net,
)

Usb2 = interface(
    DP=Net("D_P"),
    DM=Net("D_N"),
)

Usb3 = interface(
    DP=Net,
    DM=Net,
    SS_TX_N=Net,
    SS_TX_P=Net,
    SS_RX_N=Net,
    SS_RX_P=Net,
)

Gpio = interface(
    NET=Net,
)

Pwm = interface(
    NET=Net,
)

PwmPair = interface(
    A=Net,
    B=Net,
)

Analog = interface(
    NET=Net,
)

Ethernet = interface(
    TX_P=Net,
    TX_N=Net,
    RX_P=Net,
    RX_N=Net,
)

Rmii = interface(
    TXD0=Net,
    TXD1=Net,
    TX_EN=Net,
    RXD0=Net,
    RXD1=Net,
    CRS_DV=Net,
    REF_CLK=Net,
)

Mii = interface(
    TXD0=Net,
    TXD1=Net,
    TXD2=Net,
    TXD3=Net,
    TX_EN=Net,
    TX_CLK=Net,
    RXD0=Net,
    RXD1=Net,
    RXD2=Net,
    RXD3=Net,
    RX_DV=Net,
    RX_CLK=Net,
    RX_ER=Net,
    COL=Net,
    CRS=Net,
)

Mdio = interface(
    MDC=Net,
    MDIO=Net,
)

Jtag = interface(
    TDI=Net,
    TDO=Net,
    TCK=Net,
    TMS=Net,
    TRST=Net,
)

I2s = interface(
    BCLK=Net,
    LRCLK=Net,
    SDATA=Net,
    MCLK=Net,
)

Sdio = interface(
    CLK=Net,
    CMD=Net,
    DAT0=Net,
    DAT1=Net,
    DAT2=Net,
    DAT3=Net,
)

Sdmmc = interface(
    CLK=Net,
    CMD=Net,
    DAT0=Net,
    DAT1=Net,
    DAT2=Net,
    DAT3=Net,
    DAT4=Net,
    DAT5=Net,
    DAT6=Net,
    DAT7=Net,
)

Lcd = interface(
    VSYNC=Net,
    HSYNC=Net,
    DE=Net,
    CLK=Net,
    R0=Net,
    R1=Net,
    R2=Net,
    R3=Net,
    R4=Net,
    R5=Net,
    R6=Net,
    R7=Net,
    G0=Net,
    G1=Net,
    G2=Net,
    G3=Net,
    G4=Net,
    G5=Net,
    G6=Net,
    G7=Net,
    B0=Net,
    B1=Net,
    B2=Net,
    B3=Net,
    B4=Net,
    B5=Net,
    B6=Net,
    B7=Net,
)

Mipi = interface(
    CLK_P=Net,
    CLK_N=Net,
    DATA0_P=Net,
    DATA0_N=Net,
    DATA1_P=Net,
    DATA1_N=Net,
    DATA2_P=Net,
    DATA2_N=Net,
    DATA3_P=Net,
    DATA3_N=Net,
)

Lvds = interface(
    CLK_P=Net,
    CLK_N=Net,
    DATA0_P=Net,
    DATA0_N=Net,
    DATA1_P=Net,
    DATA1_N=Net,
    DATA2_P=Net,
    DATA2_N=Net,
)

Pcie = interface(
    TX_P=Net,
    TX_N=Net,
    RX_P=Net,
    RX_N=Net,
    REFCLK_P=Net,
    REFCLK_N=Net,
    PERST=Net,
    WAKE=Net,
)

Sata = interface(
    TX_P=Net,
    TX_N=Net,
    RX_P=Net,
    RX_N=Net,
)

Hdmi = interface(
    CLK_P=Net,
    CLK_N=Net,
    D0_P=Net,
    D0_N=Net,
    D1_P=Net,
    D1_N=Net,
    D2_P=Net,
    D2_N=Net,
    CEC=Net,
    SCL=Net,
    SDA=Net,
    HPD=Net,
)

DisplayPort = interface(
    AUX_P=Net,
    AUX_N=Net,
    ML0_P=Net,
    ML0_N=Net,
    ML1_P=Net,
    ML1_N=Net,
    ML2_P=Net,
    ML2_N=Net,
    ML3_P=Net,
    ML3_N=Net,
    HPD=Net,
)
