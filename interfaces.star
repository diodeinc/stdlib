# INTERFACES OF NETS
Analog = interface(
    NET = Net,
)

Can = interface(
    CAN_H = Net,
    CAN_L = Net,
)

CanTtl = interface(
    TX = Net,
    RX = Net,
)

DiffPair = interface(
    P = Net("_P"),
    N = Net("_N"),
)

Gpio = interface(
    NET = Net,
)

Ground = interface(
    NET = Net("GND", type = "ground"),
)

I2c = interface(
    SDA = Net,
    SCL = Net,
)

I2s = interface(
    BCLK = Net,
    LRCLK = Net,
    SDATA = Net,
    MCLK = Net,
)

I3c = interface(
    SDA = Net,
    SCL = Net,
)

Jtag = interface(
    TDI = Net,
    TDO = Net,
    TCK = Net,
    TMS = Net,
    TRST = Net,
)

Lcd = interface(
    VSYNC = Net,
    HSYNC = Net,
    DE = Net,
    CLK = Net,
    R0 = Net,
    R1 = Net,
    R2 = Net,
    R3 = Net,
    R4 = Net,
    R5 = Net,
    R6 = Net,
    R7 = Net,
    G0 = Net,
    G1 = Net,
    G2 = Net,
    G3 = Net,
    G4 = Net,
    G5 = Net,
    G6 = Net,
    G7 = Net,
    B0 = Net,
    B1 = Net,
    B2 = Net,
    B3 = Net,
    B4 = Net,
    B5 = Net,
    B6 = Net,
    B7 = Net,
)

Mdio = interface(
    MDC = Net,
    MDIO = Net,
)

Mii = interface(
    TXD0 = Net,
    TXD1 = Net,
    TXD2 = Net,
    TXD3 = Net,
    TX_EN = Net,
    TX_CLK = Net,
    RXD0 = Net,
    RXD1 = Net,
    RXD2 = Net,
    RXD3 = Net,
    RX_DV = Net,
    RX_CLK = Net,
    RX_ER = Net,
    COL = Net,
    CRS = Net,
)

OneWire = interface(
    DQ = Net,
)

OscPair = interface(
    XIN = Net,
    XOUT = Net,
)

Power = interface(
    NET = Net("VCC", type = "power"),
)

Pwm = interface(
    NET = Net,
)

PwmPair = interface(
    A = Net,
    B = Net,
)

Qspi = interface(
    CS = Net,
    CLK = Net,
    IO0 = Net,
    IO1 = Net,
    IO2 = Net,
    IO3 = Net,
)

Rgmii = interface(
    TXD0 = Net,
    TXD1 = Net,
    TXD2 = Net,
    TXD3 = Net,
    TX_CTL = Net,
    TXC = Net,
    RXD0 = Net,
    RXD1 = Net,
    RXD2 = Net,
    RXD3 = Net,
    RX_CTL = Net,
    RXC = Net,
)

Rmii = interface(
    TXD0 = Net,
    TXD1 = Net,
    TX_EN = Net,
    RXD0 = Net,
    RXD1 = Net,
    CRS_DV = Net,
    REF_CLK = Net,
)

Sdio = interface(
    CLK = Net,
    CMD = Net,
    DAT0 = Net,
    DAT1 = Net,
    DAT2 = Net,
    DAT3 = Net,
)

Sdmmc = interface(
    CLK = Net,
    CMD = Net,
    DAT0 = Net,
    DAT1 = Net,
    DAT2 = Net,
    DAT3 = Net,
    DAT4 = Net,
    DAT5 = Net,
    DAT6 = Net,
    DAT7 = Net,
)

Spi = interface(
    CS = Net,
    MISO = Net,
    MOSI = Net,
    CLK = Net,
)

Swd = interface(
    SWDIO = Net,
    SWCLK = Net,
)

Uart = interface(
    TX = Net,
    RX = Net,
)

def UartPair(name_a: str, name_b: str) -> (Uart, Uart):
    txa_rxb = Net(name_a + "_TX/" + name_b + "_RX")
    rxa_txb = Net(name_a + "_RX/" + name_b + "_TX")
    uart_a = Uart(name = name_a, tx = txa_rxb, rx = rxa_txb)
    uart_b = Uart(name = name_b, tx = rxa_txb, rx = txa_rxb)
    return (uart_a, uart_b)

# INTERFACES OF INTERFACES

Csi = interface(
    clk = DiffPair,
    d0 = DiffPair,
    d1 = DiffPair,
    d2 = DiffPair,
    d3 = DiffPair,
)


DisplayPort = interface(
    aux = DiffPair,
    ml0 = DiffPair,
    ml1 = DiffPair,
    ml2 = DiffPair,
    ml3 = DiffPair,
    hpd = Net,
)

Dsi = interface(
    clk = DiffPair,
    d0 = DiffPair,
    d1 = DiffPair,
    d2 = DiffPair,
    d3 = DiffPair,
)

Edp = interface(
    aux = DiffPair,
    tx0 = DiffPair,
    tx1 = DiffPair,
    tx2 = DiffPair,
    tx3 = DiffPair,
)

Ethernet = interface(
    tx = DiffPair,
    rx = DiffPair,
)

Hdmi = interface(
    clk = DiffPair,
    d0 = DiffPair,
    d1 = DiffPair,
    d2 = DiffPair,
    i2c = I2c,
    CEC = Net,
    HPD = Net,
)

Lvds = interface(
    clk = DiffPair,
    d0 = DiffPair,
    d1 = DiffPair,
    d2 = DiffPair,
)

Mipi = interface(
    clk = DiffPair,
    d0 = DiffPair,
    d1 = DiffPair,
    d2 = DiffPair,
    d3 = DiffPair,
)

PcieGen3x2Lane = interface(
    tx0 = DiffPair,
    rx0 = DiffPair,
    tx1 = DiffPair,
    rx1 = DiffPair,
    refclk = DiffPair,
    reset_n = Net,
    wake_n = Net,
    clk_req_n = Net,
)

PcieGen3x1Lane = interface(
    tx = DiffPair,
    rx = DiffPair,
    refclk = DiffPair,
    reset_n = Net,
    wake_n = Net,
    clk_req_n = Net,
)

QLink = interface(
    clk = DiffPair,
    l0 = DiffPair,
    l1 = DiffPair,
    l2 = DiffPair,
    l3 = DiffPair,
    l4 = DiffPair,
)

Sata = interface(
    tx = DiffPair,
    rx = DiffPair,
)

Sdio = interface(
    clk = Gpio,
    cmd = Gpio,
    data0 = Gpio,
    data1 = Gpio,
    data2 = Gpio,
    data3 = Gpio,
)

Ufs = interface(
    refclk = Gpio,
    reset_n = Gpio,
    l0_rx = DiffPair,
    l0_tx = DiffPair,
    l1_rx = DiffPair,
    l1_tx = DiffPair,
)

Usb2 = interface(
    data = DiffPair,
)

Usb3 = interface(
    data = DiffPair,
    ss_tx = DiffPair,
    ss_rx = DiffPair,
)

Usb3p1 = interface(
    data = DiffPair,
    ss_tx0 = DiffPair,
    ss_rx0 = DiffPair,
    ss_tx1 = DiffPair,
    ss_rx1 = DiffPair,
)