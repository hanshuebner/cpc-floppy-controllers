----------------------------------------------------------------------------------
-- Target Devices:      Xilinx xc9572xl 
-- Tool versions:       ISE 14.7
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPC_FDC is
  port ( nDS0: out std_logic;
         nDS1: out std_logic;
         nDS2: out std_logic;
         nDS3: out std_logic;
         STEP: out std_logic;
         WGATE: out std_logic;
         TRK00: in std_logic;
         MTRON: out std_logic;

         CFG1: in std_logic;
         CFG2: in std_logic;
         CFG3: in std_logic;
         CFG4: in std_logic;

         LED1: out std_logic;
         LED2: out std_logic;
         LED3: out std_logic;
         LED4: out std_logic;

         READY: in std_logic;
         FLT_TRK0: out std_logic;
         US: in std_logic_vector(1 downto 0);
         nRW_SEEK: in std_logic;
         nRSET: in std_logic;
         FLTR_STEP: in std_logic;
         nIORD: out std_logic;
         nIOWR: out std_logic;
         RESET: out std_logic;
         nFDCCS: out std_logic;
         WE: in std_logic;

         CLK4: in std_logic;
         A: in std_logic_vector(15 downto 0);
         D0: in std_logic;
         nIORQ: in std_logic;
         nWR: in std_logic;
         nRD: in std_logic
);
end CPC_FDC;

architecture Behavioral of CPC_FDC is
  signal motor: std_logic := '0';
begin

  process (CLK4, nRSET)
  begin
    if falling_edge(CLK4) then
      if nIORQ = '0' and nWR = '0' and A = x"FA7E" then
        motor <= D0;
      elsif nRSET = '0' then
        motor <= '0';
      end if;
    end if;
  end process;

  MTRON <= motor;

  process (CLK4)
  begin
    if falling_edge(CLK4) then
      if nIORQ = '0' and A(15 downto 1) & '0' = x"FBF6" then
        nFDCCS <= '0';
      else
        nFDCCS <= '1';
      end if;
    end if;
  end process;

  nIORD <= '0' when nIORQ = '0' and nRD = '0' else '1';
  nIOWR <= '0' when nIORQ = '0' and nWR = '0' else '1';
  RESET <= not nRSET;
  FLT_TRK0 <= '1' when TRK00 = '1' and nRW_SEEK = '1' else '0';
  STEP <= '1' when FLTR_STEP = '1' and nRW_SEEK = '1' else '0';
  WGATE <= '1' when READY = '1' and WE = '1' else '0';

  nDS0 <= '0' when US = "00" else '1';
  nDS1 <= '0' when US = "01" else '1';
  nDS2 <= '0' when US = "10" else '1';
  nDS3 <= '0' when US = "11" else '1';
  
end Behavioral;



