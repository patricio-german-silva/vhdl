----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: IMain_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
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

entity IMain_TB is
--  Port ( );
end IMain_TB;

architecture Behavioral of IMain_TB is
    component IMain is
     Port (  piIMClk : in STD_LOGIC;              --                                                    Port E3
             piIMRst : in STD_LOGIC;              --                                                         SW1
             piIMEna : in STD_LOGIC;              --                                                         SW0
             piIMRx : in STD_LOGIC;               --                                                    Port A9
             poIMTx : out STD_LOGIC;              --                                                    Port D10
             poIMRxTest : out STD_LOGIC;               --                                                    IO40
             poIMTxTest : out STD_LOGIC;              --                                                     IO41
             piIMSensors : in STD_LOGIC_VECTOR(3 downto 0);  -- Sensores fisicos                             BTN0 - BTN3
             poIMSevSeg : out STD_LOGIC_VECTOR(6 downto 0);  -- Al display de 7 segmentos                    IO32 - IO27
             poIMDot : out STD_LOGIC;                        -- Al punto del display de 7 segmentos -        IO26
             poIMPowerMD : out STD_LOGIC;                    -- Al pin Enable del L293D motor derecho -      IO41
             poIMDirMD : out STD_LOGIC_VECTOR(1 downto 0);   -- A los pin dir del L293D -                    LED4 y LED5
             poIMPowerMI : out STD_LOGIC;                    -- Al pin Enable del L293D motor izquierdo -    IO40
             poIMDirMI : out STD_LOGIC_VECTOR(1 downto 0);   -- A los pin dir del L293D -                    LED6 y LED7
             poIMStat : out STD_LOGIC                        -- Led de estado - BLink de 200ms en CMD In     LED0_R (G6)
     );
    end component IMain;

    signal clk, rst, ena, rx, tx, rxtest, txtest, dot, poMD, poMI, stat: STD_LOGIC;
    signal sensors: STD_LOGIC_VECTOR(3 downto 0);
    signal sevseg: STD_LOGIC_VECTOR(6 downto 0);
    signal dirMD, dirMI: STD_LOGIC_VECTOR(1 downto 0);


    constant brt: time := 104 us;
    constant towait: time := 5 ms;
    signal input: STD_LOGIC_VECTOR(8-1 downto 0);

begin

        instIMain: IMain
        Port map ( piIMClk => clk,
             piIMRst => rst,
             piIMEna => ena,
             piIMRx => rx,
             poIMTx => tx,
             poIMRxTest => rxtest,
             poIMTxTest => txtest,
             piIMSensors=> sensors,
             poIMSevSeg => sevseg,
             poIMDot => dot,
             poIMPowerMD => poMD,
             poIMDirMD => dirMD,
             poIMPowerMI => poMI,
             poIMDirMI => dirMI,
             poIMStat => stat
         );

    pClk: process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;    


    process
       type Tcmd is array (0 to 4) of NATURAL;
       variable cmd : Tcmd;
    begin
       rst <= '1';
       ena <= '0';
       wait for 33 ns;
       ena <= '1';
       rst <= '0';
       rx <= '1';

       -- Velocidad Motor Derecho 55%
       cmd(0) := 68;
       cmd(1) := 01;
       cmd(2) := 05;
       cmd(3) := 05;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;

       -- Velocidad Motor izquierdo 20%
       cmd(0) := 68;
       cmd(1) := 02;
       cmd(2) := 02;
       cmd(3) := 00;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;


        -- Automatico, velocidad media 40%
       wait for towait;
       sensors <= "0110";
       cmd(0) := 68;
       cmd(1) := 03;
       cmd(2) := 04;
       cmd(3) := 00;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;


       -- Cambio en estado de los sensores
       wait for towait;
       sensors <= "1100";

       -- Cambio en estado de los sensores
       wait for towait;
       sensors <= "1000";

       -- Control desde PC
       cmd(0) := 68;
       cmd(1) := 05;
       cmd(2) := 00;
       cmd(3) := 00;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;


       -- Control manual de sensores a "0011"
       cmd(0) := 68;
       cmd(1) := 04;
       cmd(2) := 03;
       cmd(3) := 00;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;

       wait for towait;

       -- Control manual de sensores a "1100"
       cmd(0) := 68;
       cmd(1) := 04;
       cmd(2) := 12;
       cmd(3) := 00;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;


        -- velocidad media 75%
       wait for towait;
       cmd(0) := 68;
       cmd(1) := 03;
       cmd(2) := 07;
       cmd(3) := 05;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;

       -- Control manual de sensores a "0110"
       wait for towait;
       cmd(0) := 68;
       cmd(1) := 04;
       cmd(2) := 06;
       cmd(3) := 00;
       cmd(4) := 90;

       for n in 0 to 4 loop
           input <= STD_LOGIC_VECTOR(TO_UNSIGNED(cmd(n), 8));
           wait for brt;
           rx <= '0';
           for i in 0 to 7 loop
               wait for brt;
               rx <= input(i);
           end loop;
           wait for brt;
           rx <= '1';
        end loop;




        wait;

     end process;

end Behavioral;
