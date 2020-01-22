library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity slave_tb is
--  Port ( );
end slave_tb;

architecture Behavioral of slave_tb is
component slave_n
  port(carga_timer_s : in STD_LOGIC_VECTOR(3 DOWNTO 0);
       cuenta_timer_s : in STD_LOGIC;
       clk_entrada  : in STD_LOGIC;
       reset : in STD_LOGIC;
       done : out STD_LOGIC
  );
end component;

--Las entradas
signal carga_timer_s: std_logic_vector(3 downto 0):="0000";
signal cuenta_timer_s:std_logic:='0';
signal clk_entrada:std_logic:='0';
signal reset:std_logic;
--Las salidas

signal done:std_logic;

constant clk_period : time := 10 ns; 
 
begin


--Instanciación del slave
uut:slave_n port map(
    carga_timer_s=>carga_timer_s,
    cuenta_timer_s=>cuenta_timer_s,
    clk_entrada=>clk_entrada,
    reset=>reset,
    done=>done
  );
  
  clock_process: process
  begin
    clk_entrada <= '1';
    wait for clk_period/2.0;
    clk_entrada <= '0';
    wait for clk_period/2.0;
  end process;

  
--Proceso principal
 stimulous_processs: process
 begin
   carga_timer_s<="0000";  --inicial
   cuenta_timer_s<='0';
   wait for clk_period;
    -----------------------------------------------------------  
   carga_timer_s<="0001";-- inicio llenado1
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
 -----------------------------------------------------------  
   carga_timer_s<="0010";--  llenado1
   cuenta_timer_s<='0';
   wait for 3000*clk_period; 
     -----------------------------------------------------------    
      
   carga_timer_s<="0011";-- inicio lavado blanco
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
     -----------------------------------------------------------  
   carga_timer_s<="0100";--inicio lavado color
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
   -----------------------------------------------------------  
   carga_timer_s<="0101";-- lavado 
   cuenta_timer_s<='1';
   wait for 3000*clk_period;
  -----------------------------------------------------------  
     
   carga_timer_s<="0110";-- vacia1
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
   -----------------------------------------------------------  
   carga_timer_s<="0111";-- inicio espera
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
   -----------------------------------------------------------  
   carga_timer_s<="1000";--  espera llenado
   cuenta_timer_s<='0';
   wait for 300*clk_period;
    -----------------------------------------------------------  
   carga_timer_s<="1001";-- inicio llenado2
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
   -----------------------------------------------------------  
   carga_timer_s<="1010";--  llenado2
   cuenta_timer_s<='0';
   wait for 300*clk_period;
      -----------------------------------------------------------  
   carga_timer_s<="1011";-- inicio aclarado
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
  -----------------------------------------------------------  
   carga_timer_s<="1100";--  aclarado
   cuenta_timer_s<='1';
   wait for 3000*clk_period;
    -----------------------------------------------------------  
   carga_timer_s<="1101";--  vacia2
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
  -----------------------------------------------------------  
   carga_timer_s<="1110";-- inicio centrifugado
   cuenta_timer_s<='0';
   wait for 3000*clk_period;
  -----------------------------------------------------------  
   carga_timer_s<="1111";-- centrifugado
   cuenta_timer_s<='1';
   wait for 3000*clk_period;
end process;

 
end Behavioral;