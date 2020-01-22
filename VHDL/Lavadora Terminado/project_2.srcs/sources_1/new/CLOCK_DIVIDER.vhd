-- Divisor de la señal de reloj de la placa.
-- Se obtiene un reloj a 800Hz y un pulso a 20Hz para los displays

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


                            --clk_r es la señal de reloj de la placa
                            --señal de reloj de periodo=2*mitad periodos del reloj clk_r
entity CLOCK_DIVIDER is
   --Generic(mitad:positive:=9;           --VALOR SOLO PARA TEST. EL VALOR DEFINITIVO ES 62499
   Generic(mitad:positive:=100000;    --A 1320 Hz -->100 MHz/1250 Hz =80000      **VALOR PARA EL CASO REAL
                                        --8 displays(25 Hz cada uno) y 15 leds(70 Hz)
       --cincuenta_ms:positive:=4);   --VALOR SOLO PARA TEST. EL VALOR DEFINITIVO ES 39
    cincuenta_ms:positive:=30);  --Para los displays. a 20Hz (cambio cada 50ms)  **VALOR PARA EL CASO REAL
                                        
   Port ( clk_r : in STD_LOGIC;       --Se pone la mitad porque es cuando se produce el flanco ascendente
          reset : in STD_LOGIC;       
          clk_salida : out STD_LOGIC;      --Reloj a 800Hz
          clk_salida_50 : out STD_LOGIC);  --Pulso a 20Hz para los displays. se pone a 1 una vez cada cincuenta_ms ciclos. El resto a cero 
end CLOCK_DIVIDER;


architecture Behavioral of CLOCK_DIVIDER is
    signal comparador:STD_LOGIC:='0';
    subtype contador_t is integer range 0 to mitad;
    signal contador: contador_t;                     --Contador para el reloj de 1250Hz
    signal contador50: contador_t;                   --Contador para el pulso de 20Hz
begin


 --------------------------------------------------------------------------------------
                              --PROCESS div_frecuencia
 --------------------------------------------------------------------------------------
 -- Divisor de la señal de reloj de la placa.
 -- Se obtiene un reloj a 800Hz y un pulso a 20Hz para los displays
--------------------------------------------------------------------------------------
    div_frecuencia:process(reset,clk_r)
    begin
        if(reset='1') then         --Reset='1' hace reiniciar los contadores
            comparador<='0';
            clk_salida_50<='0';
            contador<=0;
            contador50<=0;
            
        elsif rising_edge(clk_r) then     --flanco ascendente
            if (contador>mitad-1) then    
                comparador<=NOT comparador;        ----cambia de 0 a 1 y viceversa la señal de reloj de 
                                                   ----periodo=2*mitad periodos del reloj clk_r
                contador<=0;
                                   --El pulso de 50ms (20Hz) se pone a 1 una vez cada cincuenta ms. El resto a cero
                if (comparador = '1') then
                  if (contador50>cincuenta_ms-1) then
                    clk_salida_50<='1';
                    contador50<=0;
                  else 
                    clk_salida_50<='0'; 
                    contador50<=contador50+1;
                  end if;
                end if;
            else
                contador<=contador + 1;
            end if;
        end if;

        clk_salida<=comparador;
    end process;
    
--    div_frecuencia:process(reset,clk_r)
--    begin
--        if(reset='1') then         --Reset='1' hace reiniciar los contadores
--            comparador<='0';
--            clk_salida_50<='0';
--            contador<=0;
--            contador50<=0;
            
--        elsif rising_edge(clk_r) then     --flanco ascendente
--            if (contador>mitad-1) then    
--                comparador<=NOT comparador;        ----cambia de 0 a 1 y viceversa la señal de reloj de 
--                                                   ----periodo=2*mitad periodos del reloj clk_r
--                contador<=0;
--                                   --El pulso de 50ms (20Hz) se pone a 1 una vez cada cincuenta ms. El resto a cero
--                if (comparador = '1') then
--                  if (contador50>cincuenta_ms-1) then
--                    clk_salida_50<='1';
--                    contador50<=0;
--                  else 
--                    clk_salida_50<='0'; 
--                    contador50<=contador50+1;
--                  end if;
--                end if;
--            else
--                contador<=contador + 1;
--            end if;
--        end if;

--        clk_salida<=comparador;
--    end process;
    
end Behavioral;
