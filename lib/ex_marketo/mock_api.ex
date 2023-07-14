defmodule ExMarketo.MockApi do
  @moduledoc """
  Internal API used by public layer.
  """
  @behaviour ExMarketo.Api

  def authenticate do
    {:ok,
     Tesla.Mock.json(%{
       access_token: "abc12345-1234-abcd-1234-abcd12345678:ad",
       expires_in: 3537,
       scope: "api-user@company.com",
       token_type: "bearer"
     })}
  end

  def describe_leads(_) do
    {:ok,
     Tesla.Mock.json(%{
       requestId: "abcd123456789",
       result: [
         %{
           dataType: "string",
           displayName: "Company Name",
           id: 4,
           length: 255,
           rest: %{
             name: "company",
             readOnly: false
           },
           soap: %{
             name: "Company",
             readOnly: false
           }
         },
         %{
           dataType: "string",
           displayName: "Site",
           id: 5,
           length: 255,
           rest: %{
             name: "site",
             readOnly: false
           },
           soap: %{
             name: "Site",
             readOnly: false
           }
         }
       ],
       success: true
     })}
  end

  def query_leads_by_email(_, _) do
    {:ok,
     Tesla.Mock.json(%{
       requestId: "abcd123456789",
       result: [
         %{
           id: 1_234_567,
           email: "user@company.com",
           unsubscribed: true,
           user_id: "1234"
         }
       ],
       success: true
     })}
  end

  def query_leads_by_field(_, _, _) do
    {:ok,
     Tesla.Mock.json(%{
       requestId: "abcd123456789",
       result: [
         %{
           id: 1_234_567,
           email: "user@company.com",
           unsubscribed: true,
           user_id: "1234"
         }
       ],
       success: true
     })}
  end

  def update_lead_unsubscribed_status(_, _, _) do
    {:ok,
     Tesla.Mock.json(%{
       requestId: "abcd123456789",
       result: [
         %{
           id: 1_234_567,
           status: "updated"
         }
       ],
       success: true
     })}
  end
end
