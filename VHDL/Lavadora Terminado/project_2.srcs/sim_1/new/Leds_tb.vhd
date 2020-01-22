library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Leds_tb is
end Leds_tb;

architecture Behavioral of Leds_tb is
component Leds
port(
     carga_timer_l: in STD_LOGIC_VECTOR (3 downto 0);
     contadorcincuenta : in STD_LOGIC;
     clk : in STD_LOGIC;
     salida : out STD_LOGIC_VECTOR (15 downto 0);
     ledsRGB: out STD_LOGIC_VECTOR (2 downto 0)
);
end component;

constant  cincuenta_ms:positive:=4;   --VALOR SOLO PARA TEST. EL VALOR DEFINITIVO ES 39
--       cincuenta_ms:positive:=39  --Para los displays. a 20Hz (cambio cada 50ms)  **VALOR PARA EL CASO REAL

signal count:integer:=cincuenta_ms;   --de 0 a 39. Puesto a 39 para que arranque en 0
--Las entradas
signal carga_timer_l: std_logic_vector(3 downto 0):="0000";
signal contadorcincuenta:std_logic:='0';
signal clk:std_logic:='0';

--signal reset:std_logic:='0';
--Las salidas
signal salida:std_logic_VECTOR (15 downto 0);

constant clk_period : time := 20 ns; 
 
begin

uut: Leds 
  Port map(
    clk=>clk,
    carga_timer_l=>carga_timer_l,
    contadorcincuenta=>contadorcincuenta,
    salida=>salida
  );
  
 clock_process :process
begin

contadorcincuenta <= '1';
wait for clk_period/2.0;
contadorcincuenta <= '0';
wait for clk_period/2.0;



end process;
  
  


    
programa: process
begin
    carga_timer_l<="0000";  --INICIAL
    wait for clk_period*300;
    carga_timer_l<="0001";  --INICIO LLENADO
    wait for clk_period*100;
    carga_timer_l<="0010";  --LLENADO1 
    wait for clk_period*300;
    carga_timer_l<="0100";  --INICIO LAVADO COLOR
    wait for clk_period*100;
    carga_timer_l<="0101";  --LAVADO
    wait for clk_period*300;
    carga_timer_l<="0110";  --VACIA1
    wait for clk_period*300;
    carga_timer_l<="0111";  --INICIO ESPERA
    wait for clk_period*100;
    carga_timer_l<="1000";  --ESPERA LLENADO2
    wait for clk_period*100;
    carga_timer_l<="1001";  --INICIO LLENADO2
    wait for clk_period*100;
    carga_timer_l<="1010";  --LLENADO2 
    wait for clk_period*300;
    carga_timer_l<="1011";  --INICIO ACLARADO
    wait for clk_period*100;
    carga_timer_l<="1100";  --ACLARADO
    wait for clk_period*300;
    carga_timer_l<="1101";  --VACIA2
    wait for clk_period*300;
    carga_timer_l<="1110";  --INICIO CENTRIFUGADO
    wait for clk_period*100;
    carga_timer_l<="1111";  --CENTRIFUGADO
    wait for clk_period*300;
end process;

end Behavioral;