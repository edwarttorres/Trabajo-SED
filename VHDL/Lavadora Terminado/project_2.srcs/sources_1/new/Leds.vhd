library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Leds is
--   generic(
--       cincuenta_ms:positive:=4   --VALOR SOLO PARA TEST. EL VALOR DEFINITIVO ES 39
--       --cincuenta_ms:positive:=39  --Para los displays. a 20Hz (cambio cada 50ms)  **VALOR PARA EL CASO REAL
--   );
  
   Port (carga_timer_l : in STD_LOGIC_VECTOR (3 downto 0);
         contadorcincuenta : in STD_LOGIC;
         
        -- clk : in STD_LOGIC;
         salida : out STD_LOGIC_VECTOR (15 downto 0)); --representa los estados de encendido/apagado de los 16 LEDs
end Leds;


architecture Behavioral of Leds is

signal estado:std_logic_vector(2 downto 0);  --guarda el tipo de representación de los LEDs                                        
signal ultimo_estado : STD_LOGIC_VECTOR (2 downto 0) :="000"; --Conserva el valor del último estado
signal counterled: integer:=0;   --de 0 a 16. 
signal parpadeo:std_logic:='0';

begin


---------------------------------------------------------------------------------------
    -- Proceso que calcula el valor de "estado" en función de carga_timer_l  
    -- Varios de los tipos de estados de la lavadora representados por carga_timer_l 
    -- se pueden representar con un mismo valor de "estado"
---------------------------------------------------------------------------------------
--  process(carga_timer_l)
--  Begin
--     if (carga_timer_l="0000") then        --ESTADO INICIAL         
--         estado<="000";
--     elsif (carga_timer_l="0010") or (carga_timer_l="1010") then  --estados LLENADO1, LLENADO2
--         estado<="001";
--     elsif (carga_timer_l="0101") or (carga_timer_l="1100") then  --estados LAVADO, ACLARADO
--         estado<="010";                  
--     elsif (carga_timer_l="0110") or (carga_timer_l="1101") then  --estados VACIA1, VACIA2
--         estado<="011";
--     elsif (carga_timer_l="1111") then   --estado CENTRIFUGADO
--        estado<="100";
--     else estado<="101";    --Resto de estados 
--     end if;
--  end process;
  
  
---------------------------------------------------------------------------------------
      -- Proceso que calcula salida en función del valor de "estado" 
      -- salida representa los estados de encendido/apagado de los 16 LEDs
  ---------------------------------------------------------------------------------------
  process(carga_timer_l, counterled)
  begin
    case carga_timer_l is
       when "0000" =>        
           salida<="1111111111111111";
       when "0010" =>
           case(counterled) is
              when 0 =>
                 salida<="0000000000000001";
              when 1 =>
                 salida<="0000000000000011";
              when 2 =>
                 salida<="0000000000000111";
              when 3 =>
                 salida<="0000000000001111";
              when 4 =>
                 salida<="0000000000011111";
              when 5 =>
                 salida<="0000000000111111";
              when 6 =>
                 salida<="0000000001111111";
              when 7 =>
                 salida<="0000000011111111";
              when 8 =>
                 salida<="0000000111111111";
              when 9 =>
                 salida<="0000001111111111";
              when 10 =>
                 salida<="0000011111111111";
              when 11 =>
                 salida<="0000111111111111";
              when 12 =>
                 salida<="0001111111111111";
              when 13 =>
                 salida<="0011111111111111";
              when 14 =>
                 salida<="0111111111111111";
              when 15 =>
                 salida<="1111111111111111";
              when 16 =>
                 salida<="0000000000000000";
              when others=>
                 salida<="0000000000000000";
           end case;  
          
             
       when "0101" =>
           if (parpadeo='1') then
               salida<="1111111111111111";
           elsif parpadeo='0' then
               salida<="0000000000000000";
           end if;
             
       when "0110"  => -- Vaciado, va de todos a ninguno
           case(counterled) is
              when 0 =>
                 salida<="1111111111111111";
              when 1 =>
                 salida<="0111111111111111";
              when 2 =>
                 salida<="0011111111111111";
              when 3 =>
                 salida<="0001111111111111";
              when 4 =>
                 salida<="0000111111111111";
              when 5 =>
                 salida<="0000011111111111";
              when 6 =>
                 salida<="0000001111111111";
              when 7 =>
                 salida<="0000000111111111";
              when 8 =>
                 salida<="0000000011111111";
              when 9 =>
                 salida<="0000000001111111";
              when 10 =>
                 salida<="0000000000111111";
              when 11 =>
                 salida<="0000000000011111";
              when 12 =>
                 salida<="0000000000001111";
              when 13 =>
                 salida<="0000000000000111";
              when 14 =>
                 salida<="0000000000000011";
              when 15 =>
                 salida<="0000000000000001";
              when 16 =>
                 salida<="0000000000000000";
              when others=>
                 salida<="0000000000000000";
           end case;   
       
           
       when "1111" => --centrifugado
           case(counterled) is
              when 0 =>
                 salida<="1111111111111111";
              when 1 =>
                 salida<="0111111111111111";
              when 2 =>
                 salida<="1011111111111111";
              when 3 =>
                 salida<="1101111111111111";
              when 4 =>
                 salida<="1110111111111111";
              when 5 =>
                 salida<="1111011111111111";
              when 6 =>
                 salida<="1111101111111111";
              when 7 =>
                 salida<="1111110111111111";
              when 8 =>
                 salida<="1111111011111111";
              when 9 =>
                 salida<="1111111101111111";
              when 10 =>
                 salida<="1111111110111111";
              when 11 =>
                 salida<="1111111111011111";
              when 12 =>
                 salida<="1111111111101111";
              when 13 =>
                 salida<="1111111111110111";
              when 14 =>
                 salida<="1111111111111011";
              when 15 =>
                 salida<="1111111111111101";
              when 16 =>
                 salida<="1111111111111110";
              when others=>
                 salida<="0000000000000000";
           end case;   
           
       when others=>
           salida<="0000000000000000";
          
    end case;            
  end process;


 ---------------------------------------------------------------------------------------
      -- Proceso que cambia el valor de counterled de 0 a 16. Cambia a 20Hz (ver CLOCK_DIVIDER)
      -- Cuando la lavadora cambia de estado, counterled se pone a 0
  ---------------------------------------------------------------------------------------
 process(counterled, contadorcincuenta, estado)
 begin
    if not (ultimo_estado = estado) then
       ultimo_estado <= estado;
       counterled <= 0;   -- Cuando cambia de estado, counterled se pone a 0
    end if;

   --contadorcincuenta se pone a 1 un pulso de cada 50, el resto a cero (ver CLOCK_DIVIDER)
      
       if (contadorcincuenta'event and contadorcincuenta='1') then 
          parpadeo<=not parpadeo;           --parpadeo cambia siempre de valor entre 0 y 1
          if (counterled=16)then            --counterled sólo devolverá valores de 0 a 16
             counterled<=0;
          else  
             counterled<= counterled +1;
          end if;
        end if;

 end process;


end Behavioral;