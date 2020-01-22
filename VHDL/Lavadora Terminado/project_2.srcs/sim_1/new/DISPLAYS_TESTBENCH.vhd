-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 19.1.2020 19:46:06 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_Display is
end tb_Display;

architecture tb of tb_Display is

    component Display
        port (carga_timer_d     : in std_logic_vector (3 downto 0);
              contadorcincuenta : in std_logic;
              cuenta_timer_d    : in std_logic;
              segmentos         : out std_logic_vector (6 downto 0));
    end component;

    signal carga_timer_d     : std_logic_vector (3 downto 0);
    signal contadorcincuenta : std_logic;
    signal cuenta_timer_d    : std_logic;
    signal segmentos         : std_logic_vector (6 downto 0);
    constant clk_period : time := 20 ns; 

begin

    dut : Display
    port map (carga_timer_d     => carga_timer_d,
              contadorcincuenta => contadorcincuenta,
              cuenta_timer_d    => cuenta_timer_d,
              segmentos         => segmentos);
 
 

clock_process :process
begin

  contadorcincuenta <= '1';
  wait for clk_period/2.0;
  contadorcincuenta <= '0';
  wait for clk_period/2.0;

end process;

--programa: process

 programa: process
 begin
    carga_timer_d<="0000";  --INICIAL
    wait for clk_period*300;
    carga_timer_d<="0001";  --INICIO LLENADO
    wait for clk_period*100;
    carga_timer_d<="0010";  --LLENADO1 
    wait for clk_period*300;
    carga_timer_d<="0100";  --INICIO LAVADO COLOR
    wait for clk_period*100;
    carga_timer_d<="0101";  --LAVADO
    wait for clk_period*300;
    carga_timer_d<="0110";  --VACIA1
    wait for clk_period*300;
    carga_timer_d<="0111";  --INICIO ESPERA
    wait for clk_period*100;
    carga_timer_d<="1000";  --ESPERA LLENADO2
    wait for clk_period*100;
    carga_timer_d<="1001";  --INICIO LLENADO2
    wait for clk_period*100;
    carga_timer_d<="1010";  --LLENADO2 
    wait for clk_period*300;
    carga_timer_d<="1011";  --INICIO ACLARADO
    wait for clk_period*100;
    carga_timer_d<="1100";  --ACLARADO
    wait for clk_period*300;
    carga_timer_d<="1101";  --VACIA2
    wait for clk_period*300;
    carga_timer_d<="1110";  --INICIO CENTRIFUGADO
    wait for clk_period*100;
    carga_timer_d<="1111";  --CENTRIFUGADO
    wait for clk_period*300;
end process;

end tb;

