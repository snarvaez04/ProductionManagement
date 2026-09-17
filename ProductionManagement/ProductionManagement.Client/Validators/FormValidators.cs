using System.Numerics;

namespace ProductionManagement.Client.Validators
{
    public class FormValidators
    {
        public static string ValidateNumber<T>(T value) where T : INumber<T>
        {
            if (value <= T.Zero)
            {
                return "Value must be greater than 0.";
            }

            return null;
        }

        public static string ValidateDate(DateTime? date)
        {
            if (date == null)
            {
                return "Date is required.";
            }

            if (date.Value.Date <= DateTime.Today.Date)
            {
                return "Date must be at least one day in the future.";
            }

            return null;
        }

        public static string ValidateSelect(int value)
        {
            if (value == 0)
            {
                return "A value must be selected";
            }

            return null;
        }
    }
}
