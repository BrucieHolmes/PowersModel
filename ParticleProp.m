classdef ParticleProp < handle
    properties
        R = 8.314
        N_ng
        K_ng
        K_diff
        N_sf
        K_sf
        H
        Ea
        volPC
        alpha
    end
    methods
        function this = ParticleProp( K_ng, N_ng, K_diff, K_sf, N_sf, H, Ea, volPC, noTimeSteps, alpha0)
            this.H = H;
            this.K_diff = K_diff;
            this.N_ng = N_ng;
            this.N_sf = N_sf;
            this.K_sf = K_sf;
            this.K_ng = K_ng;
            this.Ea = Ea;
            this.volPC = volPC;
            this.alpha = zeros(noTimeSteps,1);
            this.alpha(1) = alpha0;
        end
        function arr = Arrhenius(this, T, Tref)
            arr = exp(this.Ea * ((1 / Tref)-(1 / T)) / this.R);
        end

        function R_Nuc = R_Nucleation(this, alpha_t)
            R_Nuc =  this.K_ng * (1 - alpha_t) * ((-log(1 - alpha_t))^(1 - this.N_ng)) / ...
                     this.N_ng;
        end
        function R_Diff = R_Diffusion(this, alpha_t)
            R_Diff = this.K_diff * (1 - alpha_t)^(2.0 / 3.0) / ...
                                   (1 - (1 - alpha_t)^(1.0 / 3.0));
        end
        function R_She = R_ShellFormation(this, alpha_t)
            R_She =  this.K_sf * ((1 - alpha_t)^this.N_sf);
        end
        function this = next_alpha(this, TimeStep, ...
                                  alphaT, ...
                                  T, ...
                                  Tref, ...
                                  RHeffect, ...
                                  wc_ratio, ...
                                  As_Af, ...
                                  dt)
            Rt_NG = this.R_Nucleation(this.alpha(TimeStep - 1));
            Rt_Df = this.R_Diffusion(this.alpha(TimeStep - 1));
            Rt_SF = this.R_ShellFormation(this.alpha(TimeStep - 1));
            arr = this.Arrhenius(T, Tref);

            Rt_NG = Rt_NG * arr * RHeffect;
            Rt_Df = Rt_Df * arr * RHeffect;
            Rt_SF = Rt_SF * arr * RHeffect;

            f_wc = (1 + 3.3333 * (this.H * wc_ratio - alphaT))^ 4;

            if this.H * wc_ratio <= alphaT
                Rt_NG = Rt_NG * f_wc;
                Rt_Df = Rt_Df * f_wc;
                Rt_SF = Rt_SF * f_wc;
            end

            a = [ Rt_NG * dt * As_Af, Rt_Df * dt, Rt_SF * dt];
            this.alpha(TimeStep) = this.alpha(TimeStep-1) + min( a );
        end
        
        
    end
end