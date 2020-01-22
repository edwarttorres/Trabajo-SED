
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY CLOCK_DIVIDER_tb IS
END CLOCK_DIVIDER_tb;

architecture Behavioral of CLOCK_DIVIDER_tb is
    COMPONENT CLOCK_DIVIDER
    PORT(
    clk_r : IN  std_logic;
    reset   : IN  std_logic;        
    clk_salida : out STD_LOGIC;      --Reloj a 800Hz
    clk_salida_50 : out STD_LOGIC  --Pulso a 20Hz para los displays. se pone a 1 una vez cada cincuenta_ms ciclos. El resto a cero 
    );
    END COMPONENT;

-- Entradas
    signal clk_r : std_logic := '0';
    signal reset   : std_logic := '0';
    signal clk_salida :std_logic;
    signal clk_salida_50 :std_logic;
-- Salidas
 
    constant entrada_t : time := 20 ns; 
begin
 -- Instanciamos la unidad bajo prueba
   uut: CLOCK_DIVIDER PORT MAP (
       clk_r => clk_r,
       reset   => reset,
       clk_salida=> clk_salida,
       clk_salida_50=> clk_salida_50
   );

   -- Definimos el reloj
   entrada_process :process
       begin
       clk_r <= '0';
       wait for entrada_t / 2;
       clk_r <= '1';
       wait for entrada_t / 2;
   end process;

   -- Procesamiento de estímulos
   estimulos: process
   begin
       reset <= '1'; -- Condiciones iniciales.
       wait for 100 ns;
       reset <= '0'; 
       wait;
   end process;
end behavioral;