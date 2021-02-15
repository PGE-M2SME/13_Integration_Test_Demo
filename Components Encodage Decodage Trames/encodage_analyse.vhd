library ieee;
use ieee.std_logic_1164.all;

entity encodage_analyse is
port( 	clk : in std_logic;
		data_dispo_sdi : in std_logic;
		data_dispo_dvi : in std_logic;
		vid_format : in std_logic_vector(1 downto 0);
		frame_format : in std_logic_vector(2 downto 0);
		vblank : in std_logic_vector(15 downto 0);
		hblank : in std_logic_vector(15 downto 0);
		vsync : in std_logic_vector(15 downto 0);
		hsync : in std_logic_vector(15 downto 0);
		vresolution : in std_logic_vector(15 downto 0);
		hresolution : in std_logic_vector(15 downto 0);
		data_in : out std_logic_vector(7 downto 0);
		data_valid_in : out std_logic
	);
end encodage_analyse;

architecture arch of encodage_analyse is
type etat is (etat0, reception_sdi, reception_dvi, 
transi_valid_sdi1, transi_valid_sdi2, transi_valid_sdi3, transi_valid_sdi4, transi_valid_sdi5, transi_valid_sdi6, transi_valid_sdi7, transi_valid_sdi8, transi_valid_sdi9, 
transi_valid_dvi1, transi_valid_dvi2, transi_valid_dvi3, transi_valid_dvi4, transi_valid_dvi5, transi_valid_dvi6, transi_valid_dvi7, transi_valid_dvi8, transi_valid_dvi9, 
transi_valid_dvi10, transi_valid_dvi11, transi_valid_dvi12, transi_valid_dvi13, transi_valid_dvi14, transi_valid_dvi15,
etat1_sdi, etat2_sdi, etat3_sdi, etat4_sdi, etat5_sdi, etat6_sdi, etat7_sdi, etat8_sdi, etat9_sdi,
etat1_dvi, etat2_dvi, etat3_dvi, etat4_dvi, etat5_dvi, etat6_dvi, etat7_dvi, etat8_dvi, etat9_dvi, etat10_dvi, etat11_dvi, etat12_dvi, etat13_dvi, etat14_dvi, etat15_dvi
				);
signal etat_present, etat_suivant : etat :=etat0;

constant nb_octets_sdi : std_logic_vector(7 downto 0) := "00001001";
constant nb_octets_dvi : std_logic_vector(7 downto 0) := "00001111";
constant id_sys_sdi : std_logic_vector(7 downto 0) := "00000010";
constant id_sys_dvi : std_logic_vector(7 downto 0) := "00000010";
constant id_cmd_sdi : std_logic_vector(7 downto 0) := "00000001";
constant id_cmd_dvi : std_logic_vector(7 downto 0) := "00000011";

signal ivid_format : std_logic_vector(1 downto 0):="00";
signal iframe_format : std_logic_vector(2 downto 0):="000";
signal ivblank : std_logic_vector(15 downto 0):="0000000000000000";
signal ihblank : std_logic_vector(15 downto 0):="0000000000000000";
signal ivsync : std_logic_vector(15 downto 0):="0000000000000000";
signal ihsync : std_logic_vector(15 downto 0):="0000000000000000";
signal ivresolution : std_logic_vector(15 downto 0):="0000000000000000";
signal ihresolution : std_logic_vector(15 downto 0):="0000000000000000";

begin

process(clk)
begin
if clk'event and clk='1' then
	etat_present <= etat_suivant;
end if;
end process;

process(data_dispo_sdi, data_dispo_dvi, etat_present)
begin
case etat_present is 
	when etat0 => 		if data_dispo_sdi='1' then
						etat_suivant <= reception_sdi;
						elsif data_dispo_dvi='1' then
						etat_suivant <= reception_dvi;
						else
						etat_suivant <= etat0;
						end if;
						
	when reception_sdi =>	if data_dispo_sdi='1' then
							etat_suivant <= etat1_sdi;
							elsif data_dispo_sdi='0' then
							etat_suivant <= etat0;
							else
							etat_suivant <= reception_sdi;
							end if;
							
	when reception_dvi =>	if data_dispo_dvi='1' then
							etat_suivant <= etat1_dvi;
							elsif data_dispo_dvi='0' then
							etat_suivant <= etat0;
							else
							etat_suivant <= reception_dvi;
							end if;
							
	when transi_valid_sdi1 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat2_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi1;
								end if;
								
	when transi_valid_sdi2 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat3_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi2;
								end if;
								
	when transi_valid_sdi3 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat4_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi3;
								end if;
								
	when transi_valid_sdi4 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat5_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi4;
								end if;
								
	when transi_valid_sdi5 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat6_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi5;
								end if;
								
	when transi_valid_sdi6 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat7_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi6;
								end if;
								
	when transi_valid_sdi7 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat8_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi7;
								end if;
								
	when transi_valid_sdi8 =>	if data_dispo_sdi='1' then 
								etat_suivant <= etat9_sdi;
								elsif data_dispo_sdi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi8;
								end if;
								
	when transi_valid_sdi9 =>	if data_dispo_sdi='0' then 
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_sdi9;
								end if;
							
	when transi_valid_dvi1 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat2_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi1;
								end if;
								
	when transi_valid_dvi2 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat3_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi2;
								end if;
								
	when transi_valid_dvi3 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat4_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi3;
								end if;
								
	when transi_valid_dvi4 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat5_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi3;
								end if;
								
	when transi_valid_dvi5 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat6_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi5;
								end if;
								
	when transi_valid_dvi6 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat7_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi6;
								end if;
								
	when transi_valid_dvi7 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat8_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi7;
								end if;
								
	when transi_valid_dvi8 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat9_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi8;
								end if;
								
	when transi_valid_dvi9 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat10_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi9;
								end if;
								
	when transi_valid_dvi10 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat11_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi10;
								end if;
								
	when transi_valid_dvi11 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat12_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi11;
								end if;
								
	when transi_valid_dvi12 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat13_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi12;
								end if;
								
	when transi_valid_dvi13 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat14_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi13;
								end if;
								
	when transi_valid_dvi14 =>	if data_dispo_dvi='1' then 
								etat_suivant <= etat15_dvi;
								elsif data_dispo_dvi='0' then
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi14;
								end if;
								
	when transi_valid_dvi15 =>	if data_dispo_dvi='0' then 
								etat_suivant <= etat0;
								else
								etat_suivant <= transi_valid_dvi15;
								end if;
						
	when etat1_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi1;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat1_sdi;
						end if;
						
	when etat2_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi2;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat2_sdi;
						end if;
						
	when etat3_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi3;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat3_sdi;
						end if;
						
	when etat4_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi4;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat4_sdi;
						end if;
						
	when etat5_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi5;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat5_sdi;
						end if;
						
	when etat6_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi6;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat6_sdi;
						end if;
						
	when etat7_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi7;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat7_sdi;
						end if;
						
	when etat8_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi8;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat9_sdi;
						end if;
						
	when etat9_sdi =>	if data_dispo_sdi='1' then
						etat_suivant <= transi_valid_sdi9;
						elsif data_dispo_sdi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat9_sdi;
						end if;
						
						
	when etat1_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi1;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat1_dvi;
						end if;
						
	when etat2_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi2;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat2_dvi;
						end if;
						
	when etat3_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi3;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat3_dvi;
						end if;
						
	when etat4_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi4;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat4_dvi;
						end if;
						
	when etat5_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi5;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat5_dvi;
						end if;
						
	when etat6_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi6;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat6_dvi;
						end if;
						
	when etat7_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi7;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat7_dvi;
						end if;
						
	when etat8_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi8;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat8_dvi;
						end if;
						
	when etat9_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi9;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat9_dvi;
						end if;
						
	when etat10_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi10;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat10_dvi;
						end if;
						
	when etat11_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi11;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat11_dvi;
						end if;
						
	when etat12_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi12;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat12_dvi;
						end if;
						
	when etat13_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi13;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat13_dvi;
						end if;
						
	when etat14_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi14;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat14_dvi;
						end if;
						
	when etat15_dvi =>	if data_dispo_dvi='1' then
						etat_suivant <= transi_valid_dvi15;
						elsif data_dispo_dvi='0' then
						etat_suivant <= etat0;
						else
						etat_suivant <= etat15_dvi;
						end if;
	
end case;
end process;

process(etat_present, vid_format, frame_format, hblank, vblank, hsync, vsync, hresolution, vresolution, 
ivid_format, iframe_format, ihblank, ivblank, ihsync, ivsync, ihresolution, ivresolution)
begin
case etat_present is
	when etat0 => 		data_in <= "00000000";
						data_valid_in <= '0';
						
	when reception_sdi =>	ivid_format <= vid_format;
							iframe_format <= frame_format;
							ihblank <= hblank;
							ivblank <= vblank;
							
	when reception_dvi =>	ivid_format <= vid_format;
							iframe_format <= frame_format;
							ihblank <= hblank;
							ivblank <= vblank;
							ihsync <= hsync;
							ivsync <= vsync;
							ihresolution <= hresolution;
							ivresolution <= vresolution;
							
	when transi_valid_sdi1 => data_valid_in <= '0';
	when transi_valid_sdi2 => data_valid_in <= '0';
	when transi_valid_sdi3 => data_valid_in <= '0';
	when transi_valid_sdi4 => data_valid_in <= '0';
	when transi_valid_sdi5 => data_valid_in <= '0';
	when transi_valid_sdi6 => data_valid_in <= '0';
	when transi_valid_sdi7 => data_valid_in <= '0';
	when transi_valid_sdi8 => data_valid_in <= '0';
	when transi_valid_sdi9 => data_valid_in <= '0';
	
	when transi_valid_dvi1 => data_valid_in <= '0';
	when transi_valid_dvi2 => data_valid_in <= '0';
	when transi_valid_dvi3 => data_valid_in <= '0';
	when transi_valid_dvi4 => data_valid_in <= '0';
	when transi_valid_dvi5 => data_valid_in <= '0';
	when transi_valid_dvi6 => data_valid_in <= '0';
	when transi_valid_dvi7 => data_valid_in <= '0';
	when transi_valid_dvi8 => data_valid_in <= '0';
	when transi_valid_dvi9 => data_valid_in <= '0';
	when transi_valid_dvi10 => data_valid_in <= '0';
	when transi_valid_dvi11 => data_valid_in <= '0';
	when transi_valid_dvi12 => data_valid_in <= '0';
	when transi_valid_dvi13 => data_valid_in <= '0';
	when transi_valid_dvi14 => data_valid_in <= '0';
	when transi_valid_dvi15 => data_valid_in <= '0';
					
	when etat1_sdi =>	data_in <= nb_octets_sdi;
						data_valid_in <= '1';
	
	when etat2_sdi =>	data_in <= id_sys_sdi;
						data_valid_in <= '1';
	
	when etat3_sdi =>	data_in <= id_cmd_sdi;
						data_valid_in <= '1';
						
	when etat4_sdi =>	data_in <= "000000" & ivid_format;
						data_valid_in <= '1';
						
	when etat5_sdi =>	data_in <= "00000" & iframe_format;
						data_valid_in <= '1';
						
	when etat6_sdi =>	data_in <= ihblank(15 downto 8);
						data_valid_in <= '1';
						
	when etat7_sdi =>	data_in <= ihblank(7 downto 0);
						data_valid_in <= '1';
						
	when etat8_sdi =>	data_in <= ivblank(15 downto 8);
						data_valid_in <= '1';
						
	when etat9_sdi =>	data_in <= ivblank(7 downto 0);
						data_valid_in <= '1';
						
	when etat1_dvi =>	data_in <= nb_octets_dvi;
						data_valid_in <= '1';
	
	when etat2_dvi =>	data_in <= id_sys_dvi;
						data_valid_in <= '1';
	
	when etat3_dvi =>	data_in <= id_cmd_dvi;
						data_valid_in <= '1';
						
	when etat4_dvi =>	data_in <= ihresolution(15 downto 8);
						data_valid_in <= '1';
						
	when etat5_dvi =>	data_in <= ihresolution(7 downto 0);
						data_valid_in <= '1';
						
	when etat6_dvi =>	data_in <= ivresolution(15 downto 8);
						data_valid_in <= '1';
						
	when etat7_dvi =>	data_in <= ivresolution(7 downto 0);
						data_valid_in <= '1';
						
	when etat8_dvi =>	data_in <= ivsync(15 downto 8);
						data_valid_in <= '1';
						
	when etat9_dvi =>	data_in <= ivsync(7 downto 0);
						data_valid_in <= '1';
						
	when etat10_dvi =>	data_in <= ihsync(15 downto 8);
						data_valid_in <= '1';
						
	when etat11_dvi =>	data_in <= ihsync(7 downto 0);
						data_valid_in <= '1';
						
	when etat12_dvi =>	data_in <= ivblank(15 downto 8);
						data_valid_in <= '1';
						
	when etat13_dvi =>	data_in <= ivblank(7 downto 0);
						data_valid_in <= '1';
						
	when etat14_dvi =>	data_in <= ihblank(15 downto 8);
						data_valid_in <= '1';
						
	when etat15_dvi =>	data_in <= ihblank(7 downto 0);
						data_valid_in <= '1';
						
	
						
	
end case;
end process;


end arch;