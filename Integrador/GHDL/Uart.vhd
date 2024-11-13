----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:03:04 PM
-- Design Name: 
-- Module Name: Uart - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Modulo UART, 8 bits, sin paridad, sin flow control 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Solo recepcion, rs232, sin paridad, sin flow control, 8 bits
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Uart is
    Generic ( DIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUartClk : in STD_LOGIC; -- Clock de entrada
            piUartRst : in STD_LOGIC; -- Reset
    
            piUartRxEna : in STD_LOGIC; -- RX Enable
            piUartTxEna : in STD_LOGIC; -- TX Enable

            piUartRx : in STD_LOGIC;    -- Puerto RX
            poUartRxC: out STD_LOGIC; -- Receive complete - Pulso de un clock que notifica que se ha recibido un dato
            poUartRxData : out STD_LOGIC_VECTOR (8-1 downto 0);

            poUartTx : out STD_LOGIC;    -- Puerto TX
            piUartTxRdy : in STD_LOGIC;   -- Transmit ready - Hay datos en piUartTxData listos para ser enviados
            poUartTxC : out STD_LOGIC;   -- Transmit Complete - UN pulso que notifica que los datos fueron enviados
            piUartTxData : in STD_LOGIC_VECTOR (8-1 downto 0)
    );
end Uart;

architecture A_Uart of Uart is

begin

   instUaRx: entity work.UaRx(A_UaRx)
      generic map(RxDIV => DIV)
      port map(piUaRxClk => piUartClk, piUaRxRst => piUartRst, piUaRxEna => piUartRxEna, piUaRxRx => piUartRx, poUaRxC => poUartRxC, poUaRxData => poUartRxData);

   instUaTx: entity work.UaTx(A_UaTx)
      generic map(TxDIV => DIV)
      port map(piUaTxClk => piUartClk, piUaTxRst => piUartRst, piUaTxEna => piUartTxEna, poUaTxTx => poUartTx, piUaTxRdy => piUartTxRdy, poUaTxC => poUartTxC, piUaTxData => piUartTxData);

end A_Uart;
