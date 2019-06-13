using Plots
using LinearAlgebra

function findcoeffs(p,t)
        t₁ = t[1]
        t₂ = t[2]
        t₃ = t[3]
        T =    [1 t₁ t₁^2 0 0 0;
                0 0 0 1 t₁ t₁^2;
                1 t₂ t₂^2 0 0 0;
                0 0 0 1 t₂ t₂^2;
                1 t₃ t₃^2 0 0 0;
                0 0 0 1 t₃ t₃^2]
        g = T\p
        return g
end

function plotspline(p)
        Npts = Int(length(p)/2)
        P = reshape(p,(2,Npts))
        xcoords = P[1,:]
        ycoords = P[2,:]
        fig = scatter(xcoords,ycoords)
        for t = 1:Npts-2
                g = findcoeffs(p[2t-1:2t-1+5],t:t+2)
                x(t) = [1 t t^2 0 0 0]⋅g
                y(t) = [0 0 0 1 t t^2]⋅g
                if t == 1
                        plot!(fig,x,y,t,t+2)
                else
                        plot!(fig,x,y,t+1,t+2,show = true)
                end
        end
        fig
end

p = [4, 2, 12, 7, 9, 13, 7, 10, 14, 10]

plotspline(p)
