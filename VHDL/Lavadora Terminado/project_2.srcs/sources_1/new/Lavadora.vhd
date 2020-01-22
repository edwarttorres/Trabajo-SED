
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lavadora is
   Port (color : in STD_LOGIC;
         centrifuga : in STD_LOGIC;
         start : in STD_LOGIC;
         aclaradob:in std_logic;
         esta_caliente:in std_logic;
         reset : in STD_LOGIC;
         vacio : in STD_LOGIC;
         lleno : in STD_LOGIC;--¿Lavadora llena de agua?
         clk : in STD_LOGIC;--100 MHz
--         enjabonar : out STD_LOGIC;
--         calentar: out STD_LOGIC;
--         llenar : out STD_LOGIC;
--         vaciar : out STD_LOGIC;
--         lavar : out STD_LOGIC;
--         aclarar: out STD_LOGIC;
--         centrifugar: out STD_LOGIC;
--         Ritmo_low : out STD_LOGIC;
--         Ritmo_high : out STD_LOGIC;
         displays : out STD_LOGIC_VECTOR (6 downto 0);
         ledsRGB: out STD_LOGIC_VECTOR (2 downto 0);
         leds_on: out STD_LOGIC_VECTOR(15 downto 0) 
);
end Lavadora;


architecture Behavioral of Lavadora is

signal cuenta_timer:std_logic;
signal carga_timer:std_logic_vector(3 downto 0);
signal cincuenta_ms: std_logic;


component CLOCK_DIVIDER
   Port (clk_r : in STD_LOGIC;
         reset : in STD_LOGIC;
         clk_salida : out STD_LOGIC;--Nuestro reloj
         clk_salida_50 : out STD_LOGIC  --Reloj a 20Hz para los displays
);      
end component;


component Control
  Port (color : in STD_LOGIC;
        centrifuga : in STD_LOGIC;
        start : in STD_LOGIC;
        reset: in STD_LOGIC;
        aclaradob: in STD_LOGIC;
        esta_caliente: in STD_LOGIC;
        vacio : in STD_LOGIC;
        lleno : in STD_LOGIC;
        clk : in STD_LOGIC;
--        enjabonar : out STD_LOGIC;
--        calentar: out STD_LOGIC;
--        llenar : out STD_LOGIC;
--        vaciar : out STD_LOGIC;
--        lavar: out STD_LOGIC;
--        aclarar:out STD_LOGIC;
--        centrifugar : out STD_LOGIC;
--        Ritmo_low : out STD_LOGIC;
--        Ritmo_high : out STD_LOGIC;
        carga_timer_c: out STD_LOGIC_VECTOR(3 DOWNTO 0); --pulso de carga del timer
        ledsRGB: out STD_LOGIC_VECTOR (2 downto 0);
        cuenta_timer_c: out STD_LOGIC
);
end component;


component Sistema_fisico
   Port(--clk : in STD_LOGIC;
        --input: in std_logic_vector(7 downto 0);
        carga_timer_s_f:in std_logic_vector(3 downto 0);
        --cuenta_timer_s_f:in std_logic;
        contadorcincuenta:in STD_LOGIC;
        displays : out STD_LOGIC_VECTOR (6 downto 0);
        
        leds_on: out STD_LOGIC_VECTOR (15 downto 0) 
        
);
end component;
  
  
signal reloj:std_logic;
signal pulso50:std_logic;


begin
  Inst_CLOCK_DIVIDER:CLOCK_DIVIDER
    PORT MAP (
        clk_r => clk,
        reset=>reset,
        clk_salida=>reloj,
        clk_salida_50=>pulso50
  );


  Inst_Control: Control
    PORT MAP (
     --ENTRADAS
      color =>color,
      centrifuga=>centrifuga,
      start=>start,
      reset=>reset,
      aclaradob=>aclaradob,
      esta_caliente=> esta_caliente,
      vacio=>vacio,
      lleno=>lleno,
      clk=>reloj,
      --SALIDAS
--      enjabonar=>enjabonar,
--      calentar=>calentar,
--      llenar=>llenar, 
--      vaciar=>vaciar, 
--      lavar=>lavar,
--      aclarar=>aclarar,
--      centrifugar=>centrifugar,
--      Ritmo_low=>Ritmo_low,
--      Ritmo_high=>Ritmo_high, 
      carga_timer_c=>carga_timer,
      ledsRGB=>ledsRGB,
      cuenta_timer_c=>cuenta_timer
  );


  Inst_Sist_Fisico: Sistema_fisico
    PORT MAP(
      --clk=>reloj,
--      input(0)=>start,
--      input(1)=>caliente,
--      input(2)=>color,
--      input(3)=>centrifuga,
--      input(4)=>esta_caliente,
--      input(5)=>vacio,
--      input(6)=>lleno,
--      input(7)=>reset,
      carga_timer_s_f=>carga_timer,
      --cuenta_timer_s_f=>cuenta_timer,
      contadorcincuenta=>pulso50,
      displays=>displays,
      leds_on=>leds_on  
  );


end Behavioral;
