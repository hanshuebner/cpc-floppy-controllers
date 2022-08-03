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

         READY: out std_logic;
         FLT_TRK0: out std_logic;
         US0: in std_logic;
         US1: in std_logic;
         nRW_SEEK: in std_logic;
         nRSET: in std_logic;
         FLTR_STEP: in std_logic;
         nIORD: out std_logic;
         nIOWR: out std_logic;
         RESET: out std_logic;
         nFDCCS: out std_logic;
         WE: in std_logic;

         A: in std_logic_vector(15 downto 0);
         D0: in std_logic;
         nIORQ: in std_logic;
         nWR: in std_logic;
         nRD: in std_logic
);
end CPC_FDC;

architecture Behavioral of CPC_FDC is

begin
end Behavioral;



