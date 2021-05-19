# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   Functions related to the conversion from Euler angle to Euler angle and
#   axis.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

export angle_to_angleaxis

"""
    angle_to_angleaxis(θ₁::Number, θ₂::Number, θ₃::Number, rot_seq::Symbol = :ZYX)
    angle_to_angleaxis(Θ::EulerAngles)

Convert the Euler angles `θ₁`, `θ₂`, and `θ₃` [rad] with the rotation sequence
`rot_seq` to an Euler angle and axis representation.

Those values can also be passed inside the structure `Θ` (see
[`EulerAngles`](@ref)).

The rotation sequence is defined by a `:Symbol`. The possible values are:
`:XYX`, `XYZ`, `:XZX`, `:XZY`, `:YXY`, `:YXZ`, `:YZX`, `:YZY`, `:ZXY`, `:ZXZ`,
`:ZYX`, and `:ZYZ`. If no value is specified, then it defaults to `:ZYX`.

# Example

```julia-repl
julia> angle_to_angleaxis(1, 0, 0, :XYZ)
EulerAngleAxis{Float64}:
  Euler angle : 1.0 rad  (0.0174533°)
  Euler axis  : [1.0, 0.0, 0.0]

julia> Θ = EulerAngles(1, 1, 1, :XYZ);

julia> angle_to_angleaxis(Θ)
EulerAngleAxis{Float64}:
  Euler angle : 1.93909 rad  (0.0338435°)
  Euler axis  : [0.692363, 0.203145, 0.692363]
```
"""
@inline function angle_to_angleaxis(
    θ₁::Number,
    θ₂::Number,
    θ₃::Number,
    rot_seq::Symbol = :ZYX
)
    # First convert to DCM and then to Euler angle and axis.
    return dcm_to_angleaxis(angle_to_dcm(θ₁, θ₂, θ₃, rot_seq))
end

@inline function angle_to_angleaxis(Θ::EulerAngles)
    return angle_to_angleaxis(Θ.a1, Θ.a2, Θ.a3, Θ.rot_seq)
end
