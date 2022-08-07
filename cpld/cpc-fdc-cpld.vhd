----------------------------------------------------------------------------------
-- Target Devices:      Xilinx xc9572xl 
-- Tool versions:       ISE 14.7
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPC_FDC is
  port ( nRW_SEEK: in std_logic;
         FLTR_STEP: in std_logic;
         FLT_TRK0: out std_logic;
         US: in std_logic_vector(1 downto 0);
         WE: in std_logic;
         RESET: out std_logic;
         nIORD: out std_logic;
         nIOWR: out std_logic;
         nFDCCS: out std_logic;

         LED1: out std_logic;
         nVORTEX_CPC: in std_logic;

         STEP: out std_logic;
         WGATE: out std_logic;
         TRK00: in std_logic;
         MTRON: out std_logic;
         nDS0: out std_logic;
         nDS1: out std_logic;
         nDS2: out std_logic;
         nDS3: out std_logic;

         ROMA14: out std_logic;
         ROMA15: out std_logic;
         ROMA16: out std_logic;
         nROMWE: out std_logic;
         nROMOE: out std_logic;
         nROMCE: out std_logic;

         CLK4: in std_logic;
         nRSET: in std_logic;
         nROMEN: in std_logic;
         ROMDIS: out std_logic;
         READY: in std_logic;
         nWR: in std_logic;
         nRD: in std_logic;
         nIORQ: in std_logic;
         nMREQ: in std_logic;

         D0: in std_logic;

         A13: in std_logic;
         A15: in std_logic;
         A: in std_logic_vector(10 downto 0)
);
end CPC_FDC;

architecture Behavioral of CPC_FDC is
  signal motor: std_logic := '0';
  signal fdc_address: std_logic_vector(10 downto 0);
  signal fdc_select_address: std_logic_vector(11 downto 0);
begin

  process (CLK4, nRSET)
  begin
    if falling_edge(CLK4) then
      if nIORQ = '0' and nWR = '0' and A13 = '0' then
        motor <= D0;
      elsif nRSET = '0' then
        motor <= '0';
      end if;
    end if;
  end process;

  MTRON <= motor;

  process (CLK4)
  begin
    if rising_edge(CLK4) then
      if nIORQ = '0' and '0' & fdc_address = fdc_select_address then
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

  fdc_address <= A(10 downto 1) & '0';
  fdc_select_address <= x"3F6" when nVORTEX_CPC = '0' else x"37E";
  
end Behavioral;



