function rotation_matrix=PQW2ECI(arg_prg,inc_angle,RAAN)
%{
Week #11 HW
%}

R_RAAN=[cos(RAAN) sin(RAAN) 0; -sin(RAAN) cos(RAAN) 0; 0 0 1];
R_inc=[1 0 0; 0 cos(inc_angle) sin(inc_angle); 0 -sin(inc_angle) cos(inc_angle)];
R_arg=[cos(arg_prg) sin(arg_prg) 0; -sin(arg_prg) cos(arg_prg) 0; 0 0 1];

R_eci2pqw=R_arg*R_inc*R_RAAN;
R_pqw2eci=R_eci2pqw';
rotation_matrix=R_pqw2eci;

end