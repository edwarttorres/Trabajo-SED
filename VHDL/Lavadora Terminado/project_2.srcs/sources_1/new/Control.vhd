
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
  Port (color : in STD_LOGIC;
        centrifuga : in STD_LOGIC;
        start : in STD_LOGIC;
        reset: in STD_LOGIC;
        clk : in STD_LOGIC;
        aclaradob: in STD_LOGIC;
        esta_caliente: in STD_LOGIC;
        vacio : in STD_LOGIC;
        lleno : in STD_LOGIC;
--        listolavado    :in std_logic;
--        listoespera    :in std_logic;
--        listoaclarado  :in std_logic;
--        listocentrif   :in std_logic;
--        enjabonar : out STD_LOGIC;
--        calentar: out STD_LOGIC;
--        llenar : out STD_LOGIC;
--        vaciar : out STD_LOGIC;
--        lavar: out STD_LOGIC;
--        aclarar: out STD_LOGIC;
--        centrifugar : out STD_LOGIC;
--        Ritmo_low : out STD_LOGIC;
--        Ritmo_high : out STD_LOGIC;
        carga_timer_c: out STD_LOGIC_VECTOR(3 DOWNTO 0); --pulso de carga del timer
        ledsRGB: out STD_LOGIC_VECTOR (2 downto 0);
        cuenta_timer_c: out STD_LOGIC
);
end Control;

architecture Behavioral of Control is


--COMPONENT BLOQUE_TEMPORIZADOR
--  Port (carga_timer_t : in STD_LOGIC_VECTOR(3 DOWNTO 0);
--        cuenta_timer_t : in STD_LOGIC;
--        clk : in STD_LOGIC;
--        reset : in STD_LOGIC;
--        done : out STD_LOGIC);       
--end component;


COMPONENT FSM_CONTROL
  Port (color : in STD_LOGIC;
        centrifuga : in STD_LOGIC;
        start : in STD_LOGIC;
        reset: in STD_LOGIC;
        aclaradob: in STD_LOGIC;
        esta_caliente: in STD_LOGIC;
        vacio : in STD_LOGIC;
        lleno : in STD_LOGIC;
        clk : in STD_LOGIC;
        done:in STD_LOGIC;
--        listolavado    :in std_logic;
--        listoespera    :in std_logic;
--        listoaclarado  :in std_logic;
--        listocentrif   :in std_logic;
--        enjabonar : out STD_LOGIC;
--        calentar: out STD_LOGIC;
--        llenar : out STD_LOGIC;
--        vaciar : out STD_LOGIC;
--        lavar: out STD_LOGIC;
--        aclarar: out STD_LOGIC;
--        centrifugar : out STD_LOGIC;
--        Ritmo_low : out STD_LOGIC;
--        Ritmo_high : out STD_LOGIC;
        carga_timer: out STD_LOGIC_VECTOR(3 DOWNTO 0);
         ledsRGB: out STD_LOGIC_VECTOR (2 downto 0)); --pulso de carga del timer
        --cuenta_timer: out STD_LOGIC);    
end component;


signal cargar:std_logic_VECTOR(3 DOWNTO 0);
signal contar:std_logic;
signal done_ok: std_logic;


begin


Inst_FSM_CONTROL: FSM_CONTROL
    PORT MAP (
        color=>color,
        centrifuga=>centrifuga,
        start=>start,
        reset=>reset,
        aclaradob=>aclaradob,
        esta_caliente=> esta_caliente,
        vacio=>vacio,
        lleno=>lleno,
        clk=>clk,
        done=>done_ok,
--        listolavado    => listolavado,
--              listoespera =>  listoespera,
--              listoaclarado =>  listoaclarado,
--              listocentrif  => listocentrif,
--        enjabonar=>enjabonar,
--        calentar=>calentar,
--        llenar=>llenar,
--        vaciar =>vaciar,
--        lavar=>lavar,
--        aclarar=>aclarar,
--        centrifugar=>centrifugar,
--        Ritmo_low=>Ritmo_low,
--        Ritmo_high=>Ritmo_high,
        carga_timer=>cargar,
        ledsRGB=>ledsRGB
        --cuenta_timer=>contar
);


--Inst_BLOQUE_TEMPORIZADOR: BLOQUE_TEMPORIZADOR
--    PORT MAP (
--        carga_timer_t=>cargar,
--        cuenta_timer_t=>contar,
--        reset=>reset,
--        clk=>clk,
--        done=>done_ok
--);

carga_timer_c<=cargar;
cuenta_timer_c<=contar;

end Behavioral;
