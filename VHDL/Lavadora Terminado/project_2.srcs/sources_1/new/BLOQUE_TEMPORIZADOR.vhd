
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BLOQUE_TEMPORIZADOR is
Port ( 
      carga_timer_t : in STD_LOGIC_VECTOR(3 DOWNTO 0);
      cuenta_timer_t : in STD_LOGIC;
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      done : out STD_LOGIC);
end BLOQUE_TEMPORIZADOR;


architecture Behavioral of BLOQUE_TEMPORIZADOR is

COMPONENT slave_n
 Port ( 
       carga_timer_s : in STD_LOGIC_VECTOR(3 DOWNTO 0);
       cuenta_timer_s : in STD_LOGIC;
       clk_entrada : in STD_LOGIC;
       reset : in STD_LOGIC;
       done : out STD_LOGIC);
end component;
begin

Inst_slave_n: slave_n
    PORT MAP (
        carga_timer_s =>carga_timer_t,
        cuenta_timer_s => cuenta_timer_t,
        clk_entrada => clk,
        reset=>reset,
        done=>done
);

end Behavioral;
