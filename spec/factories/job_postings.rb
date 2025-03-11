FactoryBot.define do
  factory :job_posting do
    sequence(:title) { |n| "Job Title #{n}" }
    company_profile { create(:company_profile) }
    sequence(:salary) { |n| "Salary #{n}" }
    salary_currency { "USD" }
    salary_period { "monthly" }
    work_arrangement { "remote" }
    job_type { create(:job_type) }
    job_location { "City, Country" }
    description { "Something" }
  end
end
