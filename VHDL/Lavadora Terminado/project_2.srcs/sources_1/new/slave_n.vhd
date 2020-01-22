--permite esperas de tiempos diferentes asociados a cada fase de lavado

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity slave_n is
   generic(
--       diez_min:integer:=240;      --VALOR SOLO PARA TEST DISPLAY   ***NO ES PROPORCIONAL AL RESTO. SOLO PARA SIMULAR DISPLAY
--       veinte_min:integer:=480;    --VALOR SOLO PARA TEST DISPLAY
--       cinco_min:integer:=120;     --VALOR SOLO PARA TEST DISPLAY
--       diez_seg:integer:=24        --VALOR SOLO PARA TEST DISPLAY
        
--      cincuentams:integer:=20;   --VALOR SOLO PARA TEST MAQUINA ESTADOS   ***NO ES PROPORCIONAL AL RESTO. MAQUINA ESTADOS NO LO USA
--      diez_min:integer:=4;      --VALOR SOLO PARA TEST MAQUINA ESTADOS
--      veinte_min:integer:=96;    --VALOR SOLO PARA TEST MAQUINA ESTADOS
--      cinco_min:integer:=24;     --VALOR SOLO PARA TEST MAQUINA ESTADOS
--      diez_seg:integer:=8        --VALOR SOLO PARA TEST MAQUINA ESTADOS
      
        cincuentams:positive:=40; --Para los displays..  **VALORES PARA EL CASO REAL
        diez_min:positive:=4552352;--1 min en realidad
        veinte_min:positive:=10000000;--2 min en realidad
        cinco_min:positive:=2000000;--30 segundos
        diez_seg: positive:=1000000--10 s
        
--        cincuentams:positive:=40; --Para los displays..  **VALORES PARA EL CASO REAL
--        diez_min:positive:=480;--1 min en realidad
--        veinte_min:positive:=960;--2 min en realidad
--        cinco_min:positive:=240;--30 segundos
--        diez_seg: positive:=80--10 s
      );
    
    Port (carga_timer_s : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          cuenta_timer_s : in STD_LOGIC;
          clk_entrada  : in STD_LOGIC;
          reset : in STD_LOGIC;
          done : out STD_LOGIC);
end slave_n;

architecture Behavioral of slave_n is

    signal max_count:integer:=diez_min;
    signal count: INTEGER:=0;
    --signal countreset: STD_LOGIC := '0';
    signal clk_state: STD_LOGIC := '0';   --señal de reloj de periodo=max_count periodos del reloj clk_entrada
begin
   
   
--------------------------------------------------------------------------------------
     -- Carga los valores de tiempos de espera asociados a cada estado de la lavadora
     -- Aquellos que no tienen espera por tiempo sino por sensor, y los que no esperan nada, se dejan a 0
--------------------------------------------------------------------------------------
process(carga_timer_s)
begin
  case carga_timer_s is
--    when "0100" => --inicio color.
   
--        max_count<=diez_seg;
    when "0101" => --lavado.
   
        max_count<=diez_min;
--        when "0111" => --inicio espera.
   
--        max_count<=diez_seg;
    when "1000" => -- espera llenado 2
   
            max_count<=diez_seg;      
    when "1100" =>--aclarado.
    
        max_count<=cinco_min;
    when "1111" =>--centrifugado
  
     max_count<=diez_min;
      
    when others =>
       max_count<= 0;
        
  end case;
end process;


--------------------------------------------------------------------------------------
    -- Proceso que controla que transcurran los tiempos de espera asociados a cada estado de la lavadora
    -- clk_state se pone a 1 una vez pasado el tiempo de espera
--------------------------------------------------------------------------------------
process(clk_entrada ,clk_state, count)
begin
    if reset='1' then
    clk_state<='0';
    count<=0;
    elsif (cuenta_timer_s = '1') and (max_count > 0) then 
    --en proceso de cuenta
        if clk_entrada 'event and clk_entrada ='1' then   --llega flanco subida de reloj
            if count<max_count then                       --No llega a tope del contador
                count<=count +1;                          --incrementa contador 
                clk_state <='0';
            else                                     --llegó al tope del contador            
                --count<=0;                            --reinicia contador
                clk_state <='1';
            end if;
        end if;
        else 
        clk_state<='0';
        count<=0;   
      end if;
      
   done<=clk_state;
end process;
 
end Behavioral;