using System;
using System.Collections.Generic;
using System.Text;

namespace ProductionManagement.Shared.DTOs
{
    public  class CoilInspectionResults
    {
        public CreateCoilRequest Coil { get; set; }
        public bool PassedInspection { get; set; }
        public List<string> MeasurementsFailed { get; set; } = [];
    }
}
