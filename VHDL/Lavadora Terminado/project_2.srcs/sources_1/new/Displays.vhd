--Control de los displays de la lavadora

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Display is           
    Port (carga_timer_d : in STD_LOGIC_VECTOR (3 downto 0);
          contadorcincuenta:in STD_LOGIC;
          --cuenta_timer_d:in std_logic;
          --clock : in STD_LOGIC;
          segmentos: out STD_LOGIC_VECTOR(6 downto 0)
          );         
end Display;


architecture Behavioral of Display is

signal counterled: integer:=0;  --Va marcando las fases del led. De 0 a 11
signal ultimo_carga_timer_d : STD_LOGIC_VECTOR (3 downto 0) :="0000"; --Conserva el valor del último carga_timer_d


begin


---------------------------------------------------------------------------------------
    -- Proceso que cambia el valor a asignar a los segmentos del display 
    -- en función de la fase y de counterled 
---------------------------------------------------------------------------------------
process(carga_timer_d,counterled)
begin
  case carga_timer_d is        --cambia segmentos del display en función de la fase y de counterled
     when "0000" =>--Poner hola, ESTADO INICIAL                
        for counterled in 0 to 11 loop
           segmentos<="0000001";
        end loop;
  
     when "0001" =>--inicio llenado, no muestra nada
        segmentos<="0000000";
               
     when "0010" => -- estado LLENADO1 "0001000","0011100","0111110");    
        case counterled is
            when 0=>
               segmentos<="0001000";
            when 1=>
               segmentos<="0001000";
            when 2=>
               segmentos<="0011100";
            when 3=>
               segmentos<="0011100";
            when 4=>
               segmentos<="0111110";
            when 5=>
               segmentos<="0111110";
            when 6=>
               segmentos<="0001000";
            when 7=>
               segmentos<="0001000";
            when 8=>
               segmentos<="0011100";
            when 9=>
               segmentos<="0011100";
            when 10=>
               segmentos<="0111110";
            when 11 =>
               segmentos<="0111110";
            when others=>
               segmentos<="0000000";    --no muestra nada
        end case;
        
     when "0011" =>--inicio lavado blanco, no muestra nada
        segmentos<="0000000";
         
     when "0100" =>--inicio lavado color, no muestra nada
        segmentos<="0000000";
              
     when "0101" =>   --estado LAVADO   1111100","1111010","1110110","1101110","1011110","1101110","0111010","011100            
        case counterled is
            when 0 =>
               segmentos<="1111100";
            when 1=>
               segmentos<="1111100";
            when 2=>
               segmentos<="1111010";
            when 3=>
               segmentos<="1111010";
            when 4=>
               segmentos<="1110110";
            when 5=>
               segmentos<="1110110";
            when 6=>
               segmentos<="1101110";
            when 7=>
               segmentos<="1101110";
            when 8=>
               segmentos<="1011110";
            when 9=>
               segmentos<="1011110";
            when 10=>
               segmentos<="1011110";
            when 11 =>
               segmentos<="1011110";
            when others=>
                segmentos<="UUUUUUU";               
       end case;
         
     when "0110" => --estado VACIA1 "0111110","0011100","0001000"
        case counterled is
            when 0=>
               segmentos<="0111110";
            when 1=>
               segmentos<="0111110";
            when 2=>
               segmentos<="0011100";
            when 3=>
               segmentos<="0011100";
            when 4=>
               segmentos<="0001000";
            when 5=>
               segmentos<="0001000";
            when 6=>
               segmentos<="0111110";
            when 7=>
               segmentos<="0111110";
            when 8=>
               segmentos<="0011100";
            when 9=>
               segmentos<="0011100";
            when 10=>
               segmentos<="0001000";
            when 11 =>
               segmentos<="0001000";
            when others=>
               segmentos<="UUUUUUU";
        end case;
            
     when "0111" =>--inicio espera, no muestra nada
        segmentos<="0000000";
          
     when "1000" =>--espera llenado2, no muestra nada
        segmentos<="0000000";
        
     when "1001" =>--inicio llenado 2, no muestra nada
        segmentos<="0000000";
       
     when "1010" => --estado LLENADO2  "0001000","0011100","0111110");       
        case counterled is
            when 0=>
            segmentos<="0001000";
         when 1=>
            segmentos<="0001000";
         when 2=>
            segmentos<="0011100";
         when 3=>
            segmentos<="0011100";
         when 4=>
            segmentos<="0111110";
         when 5=>
            segmentos<="0111110";
         when 6=>
            segmentos<="0001000";
         when 7=>
            segmentos<="0001000";
         when 8=>
            segmentos<="0011100";
         when 9=>
            segmentos<="0011100";
         when 10=>
            segmentos<="0111110";
         when 11 =>
            segmentos<="0111110";
         when others=>
            segmentos<="0000000";    --no muestra nada
     end case;
     
     when "1011" =>--inicio aclarado, no muestra nada
        segmentos<="0000000";
     
     when "1100" => --estado ACLARADO   0111100","0111010","0110110","0101110","0011110","0101110","0111010","011100       
        case counterled is
            when 0 =>
           segmentos<="1111100";
        when 1=>
           segmentos<="1111100";
        when 2=>
           segmentos<="1111010";
        when 3=>
           segmentos<="1111010";
        when 4=>
           segmentos<="1110110";
        when 5=>
           segmentos<="1110110";
        when 6=>
           segmentos<="1101110";
        when 7=>
           segmentos<="1101110";
        when 8=>
           segmentos<="1011110";
        when 9=>
           segmentos<="1011110";
        when 10=>
           segmentos<="1011110";
        when 11 =>
           segmentos<="1011110";
        when others=>
            segmentos<="UUUUUUU";               
      end case;
   
     when "1101" =>  --estado VACIA2    "0111110","0011100","0001000"
        case counterled is
            when 0=>
               segmentos<="0111110";
            when 1=>
               segmentos<="0111110";
            when 2=>
               segmentos<="0011100";
            when 3=>
               segmentos<="0011100";
            when 4=>
               segmentos<="0001000";
            when 5=>
               segmentos<="0001000";
            when 6=>
               segmentos<="0111110";
            when 7=>
               segmentos<="0111110";
            when 8=>
               segmentos<="0011100";
            when 9=>
               segmentos<="0011100";
            when 10=>
               segmentos<="0001000";
            when 11 =>
               segmentos<="0001000";
            when others=>
               segmentos<="UUUUUUU";
        end case;
            
     when "1110" =>--inicio centrifugado, no muestra nada
         segmentos<="0000000";
        
     when "1111" => --estado CENTRIFUGADO  "0111110","1111100","1111010","1110110","1101110","1011110"
        case counterled is
            when 0=>
               segmentos<="0111110";
            when 1=>
               segmentos<="1111100";
            when 2=>
               segmentos<="1111010";
            when 3=>
               segmentos<="1110110";
            when 4=>
               segmentos<="1101110";
            when 5=>
               segmentos<="1011110";
            when 6=>
               segmentos<="0111110";
            when 7=>
               segmentos<="1111100";
            when 8=>
               segmentos<="1111010";
            when 9=>
               segmentos<="1110110";
            when 10=>
               segmentos<="1101110";
            when 11 =>
               segmentos<="1011110";
            when others=>
               segmentos<="UUUUUUU";
        end case;
        
     when others=>
        segmentos<="0000000";
   end case;    
 end process;
   
   
 ---------------------------------------------------------------------------------------
     -- Proceso que cambia el valor de counterled de 0 a 11. Cambia a 20Hz (ver CLOCK_DIVIDER)
     -- Cuando la lavadora cambia de estado, counterled se pone a 0
 ---------------------------------------------------------------------------------------
 process(counterled,contadorcincuenta,carga_timer_d)
 begin
    if not (ultimo_carga_timer_d = carga_timer_d) then
       ultimo_carga_timer_d <= carga_timer_d;
       counterled <= 0;   -- Cuando la lavadora cambia de estado, counterled se pone a 0
    end if;

   --contadorcincuenta se pone a 1 un pulso de cada 50, el resto a cero (ver CLOCK_DIVIDER)
    --if (contadorcincuenta='1') then  
       if (contadorcincuenta 'event and contadorcincuenta='1') then 
          if (counterled=11)then            --counterled sólo devolverá valores de 0 a 11
             counterled<=0;
          else  
             counterled<= counterled +1;
          end if;
        end if;
    -- end if;
 end process;

end Behavioral;
