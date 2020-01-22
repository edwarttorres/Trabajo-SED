library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FSM_CONTROL is
Generic(  diezsec: integer:=5000;
  CONSTANT veintemin: integer:=15000;
    CONSTANT diezmin: integer:=10000;
   CONSTANT cincomin: integer:=8000);
 Port (color : in STD_LOGIC;             --botón ropa color
       centrifuga : in STD_LOGIC;        --botón centrifugado
       start : in STD_LOGIC;            
       reset: in STD_LOGIC;
       aclaradob: in std_logic;            --botón agua caliente
       esta_caliente:in std_logic;        --sensor agua caliente
       vacio : in std_logic;              --sensor vacío de agua
       lleno : in std_logic;              --sensor lleno de agua
       clk : in STD_LOGIC;
       done:in std_logic;           --Se pone a 1 cuando ha pasado el tiempo asignado a un estado
--        listolavado    :in std_logic;
--              listoespera    :in std_logic;
--              listoaclarado  :in std_logic;
--              listocentrif   :in std_logic;
--       enjabonar : out STD_LOGIC;      
--       calentar: out STD_LOGIC;
--       llenar : out STD_LOGIC;
--       vaciar : out STD_LOGIC;
--       lavar: out STD_LOGIC;
--       aclarar:out STD_LOGIC;
--       centrifugar : out STD_LOGIC;
--       Ritmo_low : out STD_LOGIC;
--       Ritmo_high : out STD_LOGIC;
       carga_timer: out STD_LOGIC_VECTOR(3 DOWNTO 0);  --Toma valores de 0000 a 1111 en función del estado actual 
       ledsRGB:     out STD_LOGIC_VECTOR(2 DOWNTO 0));
       --cuenta_timer: out STD_LOGIC);   -- Sólo se pone a 1 en los estados que tienen un tiempo fijo asignado
           
end FSM_CONTROL;

architecture Behavioral of FSM_CONTROL is


TYPE estados IS (inicial,inicio_llenado1,llenado1,inicio_lavado_color,inicio_lavado_blanco,lavado,vacia1,inicio_espera,
                 espera_llenado2,inicio_llenado2,llenado2,inicio_aclarado,aclarado,vacia2,inicio_centrifugado,centrifugado);
	
    --SIGNAL entradas
    SIGNAL present_state: estados;
    SIGNAL next_state:estados;
    --SIGNAL coloraux,centriaux,calienteaux: std_logic:='0';  --- switch color, centrifugado y agua caliente--
    SIGNAL tiempo: integer range 0 to 16#1FFFF#:=0;
    SIGNAL subtiempo: integer RANGE 0 to 1023:=0;
    SIGNAL subtiempores, tiempores: boolean:= TRUE;
  
begin

  
---------------------------------------------------------------------------------------
                             --PROCESS Gen_carga_timer
---------------------------------------------------------------------------------------
    --Proceso que asigna valores a carga_timer en función del estado actual
    --También pone a 1 cuenta_timer en los estados que tienen un tiempo fijo 
    --asignado y a 0 en el resto de estados
---------------------------------------------------------------------------------------

-- Gen_carga_timer: PROCESS(clk)
--  BEGIN 
--    IF CLK'EVENT AND CLK = '1' THEN       
--       CASE present_state IS
--         WHEN inicial=>
--            carga_timer<="0000";
--            cuenta_timer<='0';
--         WHEN inicio_llenado1=>
--            carga_timer<="0001";
--            cuenta_timer<='0';
--         WHEN llenado1=>
--            carga_timer<="0010";
--            cuenta_timer<='0';
--         WHEN inicio_lavado_blanco => --TENER EN CUENTA SI ES COLOR O BLANCO
--            carga_timer<="0011";
--            cuenta_timer<='0';
--         WHEN inicio_lavado_color => --TENER EN CUENTA SI ES COLOR O BLANCO
--            carga_timer<="0100";
--            cuenta_timer<='0';
--         WHEN lavado=>
--            carga_timer<="0101";
--            cuenta_timer<='1';        --estado con espera a fin temporizador
--         WHEN vacia1 => 
--            carga_timer<="0110";
--            cuenta_timer<='0';
--         WHEN inicio_espera =>
--            carga_timer<="0111";
--            cuenta_timer<='0';
--         WHEN espera_llenado2 =>
--            carga_timer<="1000";
--            cuenta_timer<='1';
--         WHEN inicio_llenado2=>
--            carga_timer<="1001";
--            cuenta_timer<='0';
--         WHEN llenado2=>
--            carga_timer<="1010";
--            cuenta_timer<='0';
--         WHEN inicio_aclarado =>
--            carga_timer<="1011";
--            cuenta_timer<='0';
--         WHEN aclarado =>
--            carga_timer<="1100";
--            cuenta_timer<='1';      --estado con espera a fin temporizador                                  
--         WHEN vacia2 => 
--            carga_timer<="1101";
--            cuenta_timer<='0';
--         WHEN inicio_centrifugado =>
--            carga_timer<="1110";
--            cuenta_timer<='0';
--         WHEN centrifugado =>
--            carga_timer<="1111";
--            cuenta_timer<='1';
--         WHEN others =>  
--            carga_timer<="UUUU";  
--            cuenta_timer<='U';
--      END CASE; 
--    END IF;                                                    
--  END PROCESS  Gen_carga_timer ;   


---------------------------------------------------------------------------------------
                             --PROCESS CLK
---------------------------------------------------------------------------------------
    --Proceso que controla el cambio del estado actual al siguiente .
    --El cambio se realiza en el flanco de subida de la entrada  clk 
---------------------------------------------------------------------------------------
 
  state_register: process (reset, clk)
  begin
    if reset = '1' then
      present_state <= inicial;
    elsif CLK'event and CLK = '1' then
      present_state <= next_state;     
    end if;
  end process;



--------------------------------------------------------------------------------------
                            --PROCESS NEXT STATE
--------------------------------------------------------------------------------------
   --Proceso que selecciona el siguiente estado al actual.
   --En aquellos estados que tienen esperas fijas de tiempo, la entrada
   --que controla el final de la espera es   done=1 
--------------------------------------------------------------------------------------
   next_state_decoder: process (clk,present_state,start,lleno,vacio,esta_caliente,done)
   begin
          
     CASE present_state IS
  ----------------------------ESTADO INICIAL--------------------------------     
       WHEN inicial=>
          IF start='1' THEN   --No sale de inicial hasta botón arranque 
              next_state <=inicio_llenado1;     --pulsado y tambor lavadora sin agua
            else 
            next_state<= inicial; 
          END IF;

--------------------------ESTADO INICIO DEL 1ER LLENADO--------------------- 
       WHEN inicio_llenado1=> 
          IF (esta_caliente='1') THEN         --Se pulsó botón agua caliente
            
               next_state <=llenado1;
               else 
            next_state <=inicio_llenado1;
          END IF;
    
  --------------------- ESTADO DE 1ER LLENADO DEL TAMBOR--------------------          
       WHEN llenado1=> 
          IF (lleno='1') THEN   
                 --Se pulsó botón ropa color
                  next_state <= inicio_lavado_color;
             else 
            next_state <=llenado1;
          END IF;            
             
------------------ ESTADO INICIO DEL LAVADO DE ROPA DE COLOR --------------- 
       WHEN inicio_lavado_color=> 
                       ---espera temporizador
            next_state<= lavado;
        
------------------ ESTADO INICIO DEL LAVADO DE ROPA BLANCA------------------ 
       WHEN inicio_lavado_blanco=> 
          next_state <=lavado; 
              
  ---------------------------ESTADO DE LAVADO------------------------------- 
       WHEN lavado=>
          IF tiempo=veintemin then               ---espera temporizador
            next_state<= vacia1;
            else  
            next_state<= lavado;
            
          END IF;
  
 -----------------------ESTADO 1ER VACIADO DEL TAMBOR-----------------------
       WHEN vacia1=>  
        IF (vacio='1' and aclaradob='0') THEN  -- Si se pulsó botón centrifugar, centrifuga 
                 next_state <= inicio_centrifugado;
            elsif (vacio='1' and aclaradob='1') then
             next_state<=inicio_espera;
              else 
            next_state <=vacia1;
          END IF; 
           
  ----------------- ESTADO INICIO DE LA ESPERA LLENADO ---------------------
       WHEN inicio_espera => 
                
          next_state <= espera_llenado2;
          

 ---- ESTADO ESPERA ENTRE VACIADO Y LLENADO (PARA EL POSTERIOR ACLARADO)---- 
       WHEN espera_llenado2 =>
          IF tiempo=diezsec THEN                  ---espera temporizador
            next_state <= inicio_llenado2;
             else 
            next_state <=espera_llenado2;
          END IF;
             
--------------------------ESTADO INICIO DEL 2o LLENADO---------------------- 
       WHEN inicio_llenado2=> 
                  --Se pulsó botón agua caliente
            IF (esta_caliente='1') THEN 
               next_state <=llenado2;
                else 
            next_state <=inicio_llenado2;
            END IF;
          
    
 --------------------- ESTADO DE 2o LLENADO DEL TAMBOR----------------------        
       WHEN llenado2=>
          IF (lleno ='1') THEN
               next_state<= inicio_aclarado;
                else 
            next_state <=llenado2;
          END IF;
             
 --------------------- ESTADO INICIO DEL  ACLARADO  ------------------------     
       WHEN inicio_aclarado =>          
          next_state <= aclarado;
           
--------------------- ESTADO DE ACLARADO DE LA ROPA ------------------------         
       WHEN aclarado=>        
          IF tiempo=diezmin THEN           ---espera temporizador
            next_state <= vacia2;  
               else 
            next_state <=aclarado;
                     
          END IF;
                  
 ------------------------ESTADO 2o VACIADO DEL TAMBOR-----------------------            
       WHEN vacia2=>         
         
             IF vacio='1'  THEN  -- Si se pulsó botón centrifugar, centrifuga 
                 next_state <= inicio_centrifugado;
                  else 
            next_state <=vacia2;  
            
          END IF;
              
--------------------- ESTADO INICIO DEL CENTRIFUGADO  -----------------------  
       WHEN inicio_centrifugado =>
       if centrifuga='1' THEN
          next_state <=centrifugado;
          elsif centrifuga='0' THEN
            next_state <=INICIAL; 
       END IF;
               
----------------------ESTADO DE CENTRIFUGADO DE LA ROPA ---------------------           
       WHEN centrifugado=>           
          IF tiempo=cincomin THEN           --espera temporizador
             next_state<= inicial;      --tras centrifugar se acaba el ciclo 
           else 
            next_state <=centrifugado; 
          END IF;  
          
       WHEN others=>          
          next_state<= inicial;
                    
     END CASE;
   
  END PROCESS ;
   

--------------------------------------------------------------------------------------
                              --PROCESS SALIDA
--------------------------------------------------------------------------------------
  -- Proceso que va asignando las salidas (acciones) en función del estado de 
  -- la lavadora y de las señales de entrada
--------------------------------------------------------------------------------------
          
   salida: PROCESS(present_state)
   BEGIN
   carga_timer<="0000";
          --cuenta_timer<='0';   
          ledsRGB<="000";   
     CASE present_state IS

 ------------------------ESTADO INICIAL---------------------------             
       WHEN inicial=>
         carga_timer<="0000";
           tiempores<=TRUE; 
           subtiempores<=TRUE;
           ledsRGB<="000";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0'; 
          
-----------------ESTADO INICIO DEL 1ER LLENADO--------------------         
       WHEN inicio_llenado1=>
       carga_timer<="0001";
       tiempores<=TRUE;
          -- cuenta_timer<='0';
           ledsRGB<="000";
--          vaciar<='0';
--            llenar<='0';
--          enjabonar<='0'; 
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';     --Botón agua caliente apretado
--          calentar<='1';
       
           
--------------- ESTADO DE 1ER LLENADO DEL TAMBOR------------------     
       WHEN llenado1 =>  
        carga_timer<="0010";
        tiempores<=TRUE;
           --cuenta_timer<='0';
           ledsRGB<="000";    
--         vaciar<='0';
--            llenar<='1';
--          enjabonar<='1'; 
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';     --Botón agua caliente apretado
--          calentar<='1';
-------------- ESTADO INICIO DEL LAVADO DE ROPA DE COLOR ---------      
       WHEN inicio_lavado_color=>
         carga_timer<="0100";
         tiempores<=TRUE;
            --cuenta_timer<='0';
            ledsRGB<="000";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';
          
------------ ESTADO INICIO DEL LAVADO DE ROPA BLANCA--------------       
       WHEN inicio_lavado_blanco=>
         carga_timer<="0011";
         tiempores<=TRUE;
            --cuenta_timer<='0';
            ledsRGB<="000";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';
            
------------------------ESTADO DE LAVADO--------------------------               
       WHEN lavado=>
          carga_timer<="0101";
         tiempores<=FALSE;
           --cuenta_timer<='1'; 
           IF COLOR='1' THEN
           ledsRGB<="010";
           ELSE
           ledsRGB<="000";
           END IF;
           --ledsRGB<="010";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='1';
--          centrifugar<='0';
--          ritmo_low<='1'; 
--          ritmo_high<='0';
-----------------ESTADO 1ER VACIADO DEL TAMBOR--------------------              
       WHEN vacia1=>            
       carga_timer<="0110";
       tiempores<=TRUE;
            --cuenta_timer<='0';
             IF COLOR='1' THEN
           ledsRGB<="010";
           ELSE
           ledsRGB<="000";
           END IF;
           
            --ledsRGB<="010";
--             vaciar<='1';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';
 --------------- ESTADO INICIO DE LA ESPERA LLENADO --------------     
       WHEN inicio_espera =>
        carga_timer<="0111";
        tiempores<=TRUE;
            --cuenta_timer<='0';
            ledsRGB<="100";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';
               
 ------ ESTADO ESPERA ENTRE VACIADO1 Y LLENADO2 (10 segundos)-----  
       WHEN espera_llenado2 =>
       carga_timer<="1000";
      tiempores<=FALSE;
           --cuenta_timer<='1';
           ledsRGB<="100";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';
         
  -------------------ESTADO INICIO DEL 2o LLENADO-----------------                
       WHEN inicio_llenado2 => 
        carga_timer<="1001";
        tiempores<=TRUE;
            --cuenta_timer<='0';
            ledsRGB<="100";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='1';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';

 ------------------ ESTADO DE 2o LLENADO DEL TAMBOR---------------                 
        WHEN llenado2 => 
          carga_timer<="1010";
          tiempores<=TRUE;
          --cuenta_timer<='0';
          ledsRGB<="100";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='1';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';
 
 ----------------- ESTADO INICIO DEL  ACLARADO  ------------------     
        WHEN inicio_aclarado =>
          carga_timer<="1011";
          tiempores<=TRUE;
            --cuenta_timer<='0';
            ledsRGB<="100";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';

 ------------------ ESTADO INICIO DEL  ACLARADO  -----------------                 
        WHEN aclarado=>
          carga_timer<="1100";
         tiempores<=FALSE;
           --cuenta_timer<='1'; 
           ledsRGB<="100"; 
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='1';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='1'; 
--          ritmo_high<='0';

 ---------------------ESTADO 2o VACIADO DEL TAMBOR----------------   
        WHEN vacia2=>                  
          carga_timer<="1101";
          tiempores<=TRUE;
            --cuenta_timer<='0';
            ledsRGB<="100";
--             vaciar<='1';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';

 ------------------ ESTADO INICIO DEL CENTRIFUGADO  --------------              
        WHEN inicio_centrifugado =>  
          carga_timer<="1110";
          tiempores<=TRUE;
           --cuenta_timer<='0';
           ledsRGB<="001";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='0';
--          ritmo_low<='0'; 
--          ritmo_high<='0';
  -----------------ESTADO DE CENTRIFUGADO DE LA ROPA -------------               
        WHEN centrifugado=>
            carga_timer<="1111";
          tiempores<=FALSE;
           --cuenta_timer<='1';
           ledsRGB<="001";
--             vaciar<='0';    
          
--                         --todas las salidas son 0 en el inicio
--          llenar<='0';
--          enjabonar<='0'; 
--          calentar<='0';
--          aclarar<='0';
--          lavar<='0';
--          centrifugar<='1';
--          ritmo_low<='1'; 
--          ritmo_high<='0';

 -----------------------------others -----------------------------          
     WHEN OTHERS =>
       carga_timer<="1111";
          tiempores<=TRUE;
           --cuenta_timer<='1';
           ledsRGB<="000";
                    
     END CASE;
   END PROCESS salida;
   
   contador:
   PROCESS(clk)
   BEGIN
    IF clk'event and clk ='1' THEN
        IF TIEMPORES THEN 
        tiempo<=0;
        ELSE
        tiempo<=tiempo+1;
        END IF;
    END IF;
    END PROCESS contador;

---------------------------------------------------------------------------
               --PROCESS SELECCIÓN DE CENTRIFUGADO S/N
---------------------------------------------------------------------------
   
    
    
---------------------------------------------------------------------------
               --PROCESS SELECCIÓN DE ROPA DE COLOR O BLANCA 
---------------------------------------------------------------------------


---------------------------------------------------------------------------
              --PROCESS SELECCIÓN DE AGUA CALIENTE O FRIA
---------------------------------------------------------------------------
 

END BEHAVIORAL;
