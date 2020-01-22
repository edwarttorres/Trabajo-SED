library ieee;
use ieee.std_logic_1164.all;

entity tb_Control is
end tb_Control;

architecture tb of tb_Control is

    component Control
        port (color          : in std_logic;
              centrifuga     : in std_logic;
              start          : in std_logic;
              reset          : in std_logic;
              clk            : in std_logic;
              aclaradob       : in std_logic;
              esta_caliente  : in std_logic;
              vacio          : in std_logic;
              lleno          : in std_logic;
              listolavado    :in std_logic;
              listoespera    :in std_logic;
              listoaclarado  :in std_logic;
              listocentrif   :in std_logic;
              
--              enjabonar      : out std_logic;
--              calentar       : out std_logic;
--              llenar         : out std_logic;
--              vaciar         : out std_logic;
--              lavar          : out std_logic;
--              aclarar        : out std_logic;
--              centrifugar    : out std_logic;
--              Ritmo_low      : out std_logic;
--              Ritmo_high     : out std_logic;
              carga_timer_c  : out std_logic_vector (3 downto 0));
              --cuenta_timer_c : out std_logic);
    end component;

    signal color          : std_logic;
    signal centrifuga     : std_logic;
    signal start          : std_logic;
    signal reset          : std_logic;
    signal clk            : std_logic;
    signal aclaradob       : std_logic;
    signal esta_caliente  : std_logic;
    signal vacio          : std_logic;
    signal lleno          : std_logic;
    signal    listolavado    : std_logic;
    signal          listoespera    : std_logic;
     signal         listoaclarado  : std_logic;
     signal         listocentrif   : std_logic;
              
--    signal enjabonar      : std_logic;
--    signal calentar       : std_logic;
--    signal llenar         : std_logic;
--    signal vaciar         : std_logic;
--    signal lavar          : std_logic;
--    signal aclarar        : std_logic;
--    signal centrifugar    : std_logic;
--    signal Ritmo_low      : std_logic;
--    signal Ritmo_high     : std_logic;
    signal carga_timer_c  : std_logic_vector (3 downto 0);
    --signal cuenta_timer_c : std_logic;

constant clk_period : time := 40 ns;
begin

    dut : Control
    port map (color          => color,
              centrifuga     => centrifuga,
              start          => start,
              reset          => reset,
              clk            => clk,
              aclaradob       => aclaradob,
              esta_caliente  => esta_caliente,
              vacio          => vacio,
              lleno          => lleno,
              listolavado     =>            listolavado ,  
           listoespera        =>            listoespera   ,
           listoaclarado      =>            listoaclarado ,
           listocentrif       =>            listocentrif  ,
--              vaciar        =>  => vaciar,
--              lavar          => lavar,
--              aclarar        => aclarar,
--              centrifugar    => centrifugar,
--              Ritmo_low      => Ritmo_low,
--              Ritmo_high     => Ritmo_high,
              carga_timer_c  => carga_timer_c);
              --cuenta_timer_c => cuenta_timer_c);
    
    
 
-- Clock process
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
listolavado<='0';
listocentrif<='0';
listoespera<='0';
listoaclarado<='0';

-------------------------------------------------------INICIAL--------------------------------------------------
color<='0';             --botón ropa color
centrifuga<='0';        --botón centrifugado
aclaradob<='0';          --botón agua calente
wait for clk_period;    --espera al sensor vacio
start<='1';
---------------------------------------------------------INICIO LLENADO 1----------------------------------------------     
wait for clk_period*5.1;
listoespera<='1';
esta_caliente<='1';
listocentrif<='1';
wait for clk_period*3.3;
esta_caliente<='0';
listoespera<='0';
listocentrif<='0';
listoaclarado<='1';
lleno<='1';
wait for clk_period*2.6;
listolavado<='1';
lleno<='0';
vacio<='1';
wait for clk_period*5.7;
listoaclarado<='0';
listolavado<='0';
vacio<='0';

end process;

--resetprocess: process
--begin
--reset <= '0';
--wait for clk_period*200;
--reset <= '1';
--wait for clk_period*4;
--end process;

end tb;
