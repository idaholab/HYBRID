within NHES.Systems.PrimaryHeatSystem.HTGR.Components;
model Pebble_Bed_Rankine_Standalone_STHX_03
  extends Pebble_Bed_Rankine_Standalone_STHX_02(
    compressor_Controlled(gas_iso(state(phase(start=1)))),
    core(coolantSubchannel(state_a(phase(start=1)), state_b(phase(start=1))),
        fuelModel(Fuel_kernel(port_b1(T(start={790.9180376325126,
                  808.9378945319855,833.6825766036188,846.7840416077452}))),
          Fuel_kernel_center(port_b1(T(start={806.7688034248663,
                  822.1468660243927,846.8915480959446,857.3512188001525}))))),
    generator(shaft(tau(start=106529.6527746159))),
    resistance(port_a(p(start=11735599.702357637))),
    tee(port_2(m_flow(start=40.31413699208795))));
end Pebble_Bed_Rankine_Standalone_STHX_03;
