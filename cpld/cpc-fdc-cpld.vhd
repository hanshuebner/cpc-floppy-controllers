library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpc_fdc is
  port (
    -- CPC bus inputs
    a              : in std_logic_vector(15 downto 0);
    d0             : in std_logic;
    rd_n           : in std_logic;
    wr_n           : in std_logic;
    iorq_n         : in std_logic;
    clk4           : in std_logic;
    rset_n         : in std_logic;

    -- FDC control signal outputs
    ldcr_n         : out std_logic;
    ldor_n         : out std_logic;
    iowr_n         : out std_logic;
    iord_n         : out std_logic;
    reset          : out std_logic;
    fdccs_n        : out std_logic;

    -- Motor control output
    mtron_n        : out std_logic;

    -- Configuration signal inputs
    address_select : in std_logic
    );
end cpc_fdc;

architecture rtl of cpc_fdc is
  signal motor_latch        : std_logic := '0';
  constant FD_MOTOR_ADDR    : std_logic_vector(15 downto 0) := x"FA7E";
  constant VORTEX_FDC_ADDR  : std_logic_vector(15 downto 0) := x"FBF6";
  constant AMSTRAD_FDC_ADDR : std_logic_vector(15 downto 0) := x"FB7E";
begin

  -- Motor Latching
  process (clk4, wr_n, a, d0, rset_n)
  begin
    if rising_edge(clk4) then
      if rset_n = '0' then
        motor_latch <= '0';
      elsif wr_n = '0' and iorq_n = '0' and a = FD_MOTOR_ADDR then
        motor_latch <= d0;
      end if;
    end if;
  end process;

  -- Motor Output
  mtron_n <= '0' when motor_latch = '1' else 'Z';

  -- FDC control signals
  fdccs_n <= '0' when ((address_select = '1' and a(15 downto 1) = VORTEX_FDC_ADDR(15 downto 1))
                       or (address_select = '0' and a(15 downto 1) = AMSTRAD_FDC_ADDR(15 downto 1)))
             else '1';
  iowr_n  <= wr_n or iorq_n;
  iord_n  <= rd_n or iorq_n;
  reset   <= not rset_n;
  ldcr_n  <= '1';
  ldor_n  <= '1';

end rtl;
