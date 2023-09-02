library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegBank_tb is
end RegBank_tb;

architecture RegBank_tb_arch of RegBank_tb is
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal rdAddr1   : std_logic_vector(4 downto 0) := "00000";
    signal rdAddr2   : std_logic_vector(4 downto 0) := "00000";
    signal wrAddr    : std_logic_vector(4 downto 0) := "00000";
    signal wData     : std_logic_vector(31 downto 0) := (others => '0');
    signal we        : std_logic := '0';
    signal rdData1   : std_logic_vector(31 downto 0);
    signal rdData2   : std_logic_vector(31 downto 0);

    constant CLOCK_PERIOD : time := 10 ns;

    component RegBank
        Port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            rdAddr1  : in  std_logic_vector(4 downto 0);
            rdAddr2  : in  std_logic_vector(4 downto 0);
            wrAddr   : in  std_logic_vector(4 downto 0);
            wData    : in  std_logic_vector(31 downto 0);
            we       : in  std_logic;
            rdData1  : out std_logic_vector(31 downto 0);
            rdData2  : out std_logic_vector(31 downto 0)
        );
    end component;

begin
    uut : RegBank
        port map (
            clk      => clk,
            reset    => reset,
            rdAddr1  => rdAddr1,
            rdAddr2  => rdAddr2,
            wrAddr   => wrAddr,
            wData    => wData,
            we       => we,
            rdData1  => rdData1,
            rdData2  => rdData2
        );

    process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for CLOCK_PERIOD / 2;
            clk <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    process
    begin
        reset <= '1';
        wait for CLOCK_PERIOD;
        reset <= '0';
        wait for 10 * CLOCK_PERIOD;

        rdAddr1 <= "00010";
        rdAddr2 <= "00011";
        wait for CLOCK_PERIOD;
        wait for 10 * CLOCK_PERIOD;

        assert rdData1 = (others => 'U')
            report "Leitura de dados não gravados não resultou em valores indefinidos"
            severity error;

        assert rdData2 = (others => 'U')
            report "Leitura de dados não gravados não resultou em valores indefinidos"
            severity error;

        we <= '1';
        wData <= "01010101010101010101010101010101";
        wrAddr <= "00001";
        wait for CLOCK_PERIOD;
        we <= '0';
        wait for 10 * CLOCK_PERIOD;

        we <= '1';
        wData <= "11001100110011001100110011001100";
        wrAddr <= "11111";
        wait for CLOCK_PERIOD;
        we <= '0';
        wait for 10 * CLOCK_PERIOD;

        assert rdData1 = (others => '0')
            report "Escrita em endereço inválido não deve alterar os dados lidos"
            severity error;

        assert rdData2 = (others => '0')
            report "Escrita em endereço inválido não deve alterar os dados lidos"
            severity error;

        rdAddr1 <= "00001";
        rdAddr2 <= "00000";
        wait for CLOCK_PERIOD;
        wait for 10 * CLOCK_PERIOD;

        assert rdData1 = wData
            report "Dados no registrador 1 não correspondem ao wData"
            severity error;

        assert rdData2 = wData
            report "Dados no registrador 2 não correspondem ao wData"
            severity error;

        wait;
    end process;

end architecture RegBank_tb_arch;
