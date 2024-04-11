library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
  port (
    address : in std_logic_vector(15 downto 0);
    data_io : inout std_logic_vector(7 downto 0);
    rd_n    : in std_logic;
    wr_n    : in std_logic;
    ioreq_n : in std_logic;
    address_select: in std_logic;
    reset_n : in std_logic;
    motor   : out std_logic;
    floppycs: out std_logic;
    iowr_n  : out std_logic;
    iord_n  : out std_logic;
    reset   : out std_logic
    );
end top_level;

architecture rtl of top_level is
  signal motor_latch : std_logic := '0';
  constant VORTEX_FDC_ADDR : std_logic_vector(15 downto 0) := x"FBF6";
  constant AMSTRAD_FDC_ADDR : std_logic_vector(15 downto 0) := x"FB7E";
begin
  -- FDC chip select
  floppycs <= '0' when ((address_select = '1' and address(15 downto 1) = VORTEX_FDC_ADDR(15 downto 1))
                        or (address_select = '0' and address(15 downto 1) = AMSTRAD_FDC_ADDR(15 downto 1)))
              else '1';

  -- Motor Latching
  process (wr_n, address, data_io, reset_n)
  begin
    if reset_n = '0' then
      motor_latch <= '0';
    elsif rising_edge(wr_n) and ioreq_n = '1' and address = x"FA7E" then
      motor_latch <= data_io(0);
    end if;
  end process;

  -- Motor Output
  motor <= motor_latch;

  -- IOWR
  iowr_n <= wr_n or ioreq_n;

  -- IORD
  iord_n <= rd_n or ioreq_n;

  -- Positive logic reset
  reset <= not reset_n;

end rtl;
