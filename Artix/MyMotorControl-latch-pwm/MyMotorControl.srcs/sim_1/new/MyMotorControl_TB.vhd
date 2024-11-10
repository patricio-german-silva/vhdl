----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 05:41:18 PM
-- Design Name: 
-- Module Name: MyMotorControl_TB - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MyMotorControl_TB is
--  Port ( );
end MyMotorControl_TB;

architecture Behavioral of MyMotorControl_TB is

-- #########################################################################################
-- ##################            TP de MyPWM               #################################
-- #########################################################################################
--    component MyPWM is
--    Generic(PWM_WIDTH: NATURAL:=2;    -- Cantidad de bits del contador PWM
--            ARR: NATURAL := 4;        -- Valor en que el contador vuwlve a 0
--            DIV_WIDTH: NATURAL := 25;  -- Cantidad de bits para el contador divisor
--            DIV: NATURAL := 25000000 -- Divisor interno, la salida pwm tiene periodo T=DIV*piPwmClk.
--            );
--        Port(piPwmClk : in STD_LOGIC;
--             piPwmEna : in STD_LOGIC;
--             piPwmRst : in STD_LOGIC;
--             piPwmPowerSelEna : in STD_LOGIC;
--             piPwmPowerSel: in STD_LOGIC_VECTOR(PWM_WIDTH-1 downto 0);
--             poPower : out STD_LOGIC
--             );
--      end component;
--    signal Clk, Ena, Rst, PowerSelEna, Power : std_logic;
--    signal PowerSel: std_logic_vector(2-1 downto 0);

    
--    begin
--        instMyPWM: MyPWM
--        generic map( PWM_WIDTH => 2, ARR => 4, DIV => 3, DIV_WIDTH => 20)
--        port map(piPwmClk => Clk,
--                piPwmEna => Ena,
--                piPwmRst => Rst,
--                piPwmPowerSelEna => PowerSelEna,
--                piPwmPowerSel => Powersel,
--                poPower => Power
--         );
 
--        pClk: process
--        begin
--            Clk <= '1';
--            wait for 10 ns;
--            Clk <= '0';
--            wait for 10 ns;
--        end process;
        
--    process
--    begin
--        Rst <= '1';
--        Ena <= '0';
--        wait for 23 ns;--
        
--        Rst <= '0';
--        PowerSelEna <= '1';
--        PowerSel <= "10";
--        wait for 23 ns;
--        PowerSelEna <= '0';
--        wait for 23 ns;
--        Ena <= '1';
--        wait for 1000 ns;
        
--        ena <= '0';
--        wait for 200 ns;
--        ena <= '1';
--        wait for 200 ns;
       
--        PowerSelEna <= '1';
--        PowerSel <= "01";
--        wait for 33 ns;
--        PowerSelEna <= '0';
--        wait for 500 ns;
        
--        PowerSelEna <= '1';
--        PowerSel <= "00";
--        wait for 23 ns;
--        PowerSelEna <= '0';
--        wait for 500 ns;
        
--        PowerSelEna <= '1';
--        PowerSel <= "11";
--        wait for 23 ns;
--        PowerSelEna <= '0';
--        wait for 500 ns;
        
--        PowerSelEna <= '1';
--        PowerSel <= "10";
--        wait for 23 ns;
--        PowerSelEna <= '0';
--        wait for 500 ns;
        
--        Rst <= '1';
--        wait for 23 ns;
--        Rst <= '0';
--        wait;
--     end process;
     
     
-- #########################################################################################
-- ##################            TP de MyMotorControl      #################################
-- #########################################################################################
    component MyMotorControl is    
    Generic( N: NATURAL:=2);
    Port(piClk : in STD_LOGIC;
         piRst : in STD_LOGIC;
         piSet : in STD_LOGIC;
         piMotorSel: in STD_LOGIC;
         piDirSel : in STD_LOGIC;
         piPowerSel: in STD_LOGIC_VECTOR (N-1 downto 0);
         poDirM1 : out STD_LOGIC_VECTOR(1 downto 0);
         poDirM2 : out STD_LOGIC_VECTOR(1 downto 0);
         poPowerM1 : out STD_LOGIC;
         poPowerM2 : out STD_LOGIC
         );
     end component MyMotorControl;
     
signal Clk, Rst, Set, MotorSel, DirSel, PowerM1, PowerM2 : std_logic;
signal PowerSel: std_logic_vector(2-1 downto 0);
signal DirM1, DirM2: std_logic_vector(1 downto 0);

begin
    instMyMotorControl: MyMotorControl
        Generic map(N => 2)
        Port map ( piClk => Clk,
                 piRst => Rst,
                 piSet => Set,
                 piMotorSel => MotorSel,
                 piDirSel => DirSel,
                 piPowerSel => PowerSel,
                 poDirM1 => DirM1,
                 poDirM2 => DirM2,
                 poPowerM1 => PowerM1,
                 poPowerM2 => PowerM2
                 );

	pClk: process
	begin
		Clk <= '1';
		wait for 10 ns;
		Clk <= '0';
		wait for 10 ns;
	end process;	

    process
    begin
        -- Para setear PWM se utiliza el clock de PWM (100Hz).
        -- O se lo hace asincrono o se espera dos ciclos de clock a 100Hz o se hace la division directamente en el PWM
        -- Para test se reduce a 2 ciclos de reloj de T=10ns
        Rst <= '1';
        Set <= '0';
        wait for 33 ns;
        
        Rst <= '0';
        MotorSel <= '0';
        DirSel <= '0';
        PowerSel <= "10";
        Set <= '1';
        wait for 33 ns;
        Set <= '0';
        wait for 33 ns;
        
        MotorSel <= '1';
        DirSel <= '1';
        PowerSel <= "01";
        Set <= '1';
        wait for 33 ns;
        Set <= '0';
        wait for 3000 ns;
        
        Rst <= '1';
        wait for 500 ns; -- No output
        Rst <= '0';
        wait;
    end process;


end Behavioral;
