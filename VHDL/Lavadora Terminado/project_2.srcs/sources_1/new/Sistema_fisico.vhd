
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_fisico is
   Port (--clk : in STD_LOGIC;
         --input: in std_logic_vector(7 downto 0);
         carga_timer_s_f:in std_logic_vector(3 downto 0);
         --cuenta_timer_s_f:in std_logic;
         contadorcincuenta:in STD_LOGIC;
         displays : out STD_LOGIC_VECTOR (6 downto 0);
         
         leds_on: out STD_LOGIC_VECTOR(15 downto 0)
         
      ); 
end Sistema_fisico;


architecture Behavioral of Sistema_fisico is


COMPONENT Display
   Port (carga_timer_d: in STD_LOGIC_VECTOR (3 downto 0);
         contadorcincuenta:in STD_LOGIC;
         --cuenta_timer_d:in std_logic;
         --clock : in STD_LOGIC;
         segmentos : out STD_LOGIC_VECTOR (6 downto 0)
        );                  
end component;

COMPONENT Leds
Port(
 carga_timer_l : in STD_LOGIC_VECTOR (3 downto 0);
 contadorcincuenta : in STD_LOGIC;
 --ledsRGB: out STD_LOGIC_VECTOR (2 downto 0);
 --clk : in STD_LOGIC;
 salida : out STD_LOGIC_VECTOR (15 downto 0));
end COMPONENT;

signal inp:std_logic_vector(4 downto 0);

begin

Inst_Display: Display
    PORT MAP (
        carga_timer_d=>carga_timer_s_f,
        contadorcincuenta=> contadorcincuenta,
        --cuenta_timer_d=>cuenta_timer_s_f,
        --clock=>clk,
        segmentos=>displays 
      );
      
Inst_Leds: Leds
    PORT MAP(
     carga_timer_l=>carga_timer_s_f,
     contadorcincuenta=> contadorcincuenta,
     
     --clk=>clk,
     salida=>leds_on 
    
);
end Behavioral;
