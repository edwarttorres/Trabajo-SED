library ieee;
use ieee.std_logic_1164.all;

entity LAVADORA_TESTBENCH is
end LAVADORA_TESTBENCH;

architecture tb of LAVADORA_TESTBENCH is

    component Lavadora
        port (color         : in std_logic;
              centrifuga    : in std_logic;
              start         : in std_logic;
              caliente      : in std_logic;
              esta_caliente : in std_logic;
              reset         : in std_logic;
              vacio         : in std_logic;
              lleno         : in std_logic;
              clk           : in std_logic;
--              enjabonar     : out std_logic;
--              calentar      : out std_logic;
--              llenar        : out std_logic;
--              vaciar        : out std_logic;
--              lavar         : out std_logic;
--              aclarar       : out std_logic;
--              centrifugar   : out std_logic;
--              Ritmo_low     : out std_logic;
--              Ritmo_high    : out std_logic;
              displays      : out std_logic_vector (6 downto 0);
              ledsRGB: out STD_LOGIC_VECTOR (2 downto 0);
              leds_on       : out std_logic_vector (15 downto 0));
    end component;

    signal color         : std_logic;
    signal centrifuga    : std_logic;
    signal start         : std_logic;
    signal caliente      : std_logic;
    signal esta_caliente : std_logic;
    signal reset         : std_logic;
    signal vacio         : std_logic;
    signal lleno         : std_logic;
    signal clk           : std_logic;
--    signal enjabonar     : std_logic;
--    signal calentar      : std_logic;
--    signal llenar        : std_logic;
--    signal vaciar        : std_logic;
--    signal lavar         : std_logic;
--    signal aclarar       : std_logic;
--    signal centrifugar   : std_logic;
--    signal Ritmo_low     : std_logic;
--    signal Ritmo_high    : std_logic;
    signal displays      : std_logic_vector (6 downto 0);
    signal ledsRGB       : STD_LOGIC_VECTOR (2 downto 0);
    signal leds_on       : std_logic_vector (15 downto 0);
--DEFINICION PERIODO DEL RELOJ
    constant clk_period : time := 10 ns;    --Para usar como tiempo de espera entre fases  
                     --10 ns para test funcional. Será 1 segundo en Test de la placa real
                     --************************
begin

    dut : Lavadora
    port map (color         => color,
              centrifuga    => centrifuga,
              start         => start,
              caliente      => caliente,
              esta_caliente => esta_caliente,
              reset         => reset,
              vacio         => vacio,
              lleno         => lleno,
              clk           => clk,
              ledsRGB       =>ledsRGB,
--              enjabonar     => enjabonar,
--              calentar      => calentar,
--              llenar        => llenar,
--              vaciar        => vaciar,
--              lavar         => lavar,
--              aclarar       => aclarar,
--              centrifugar   => centrifugar,
--              Ritmo_low     => Ritmo_low,
--              Ritmo_high    => Ritmo_high,
              displays      => displays,
              leds_on       => leds_on);

  clock_process :process
begin

clk <= '1';
wait for clk_period/2.0;
clk <= '0';
wait for clk_period/2.0;



end process;

-- Stimulus process
stim_proc: process
begin

start<='0';
esta_caliente<='0';
vacio<='0';
lleno<='0';
-------------------------------------------------------INICIAL--------------------------------------------------
           --botón ropa color
          --botón centrifugado
             --botón agua calente

---------------------------------------------------------INICIO LLENADO 1----------------------------------------------     
wait for clk_period*500.1;
esta_caliente<='1';
wait for clk_period*300.3;
esta_caliente<='0';
wait for clk_period*200;    --espera al sensor vacio
start<='1';
lleno<='1';
wait for clk_period*200.6;
lleno<='0';
wait for clk_period*200.6;
vacio<='1';

wait for clk_period*500.7;
vacio<='0';

end process;

resetprocess: process
begin
--reset <= '0';
caliente<='0';
centrifuga<='0';
color<='0';
wait for clk_period*200000;
--reset <= '1';
wait for clk_period*4;
--reset <= '0';
caliente<='1';
centrifuga<='1';
color<='1';
wait for clk_period*4000000;
caliente<='0';
centrifuga<='0';
color<='0';
end process;
end tb;



