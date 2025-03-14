require 'rails_helper'

describe "Visitor sees job postings", type: :system do
  it "successfully" do
    first_user = create(:user)
    rubyoncloud = create(:company_profile, name: "Ruby on cloud", website_url: "http://rubyoncloud.com", contact_email: "contact@rubyoncloud.com", user: first_user)
    remote_job = create(:job_type, name: "Remote")
    create(:job_posting, title: "Dev Rails", salary: "1000.00", salary_currency: "USD", salary_period: "Monthly", job_type: remote_job, description: "Software Developer", company_profile: rubyoncloud)

    second_user = create(:user, email_address: 'second@user.com')
    second_company = create(:company_profile, user: second_user, contact_email: 'second@company.com')
    second_job_posting = create(:job_posting, company_profile: second_company)
    third_job_posting = create(:job_posting, company_profile: second_company)

    visit root_path

    expect(page).to have_content("Dev Rails")
    expect(page).to have_content("Ruby on cloud")
    expect(page).to have_content("Remote")
    expect(page).to have_content(second_job_posting.title)
    expect(page).to have_content(second_job_posting.company_profile.name)
    expect(page).to have_content(second_job_posting.job_type.name)
    expect(page).to have_content(third_job_posting.title)
    expect(page).to have_content(third_job_posting.company_profile.name)
    expect(page).to have_content(third_job_posting.job_type.name)
    expect(page).not_to have_content("Nenhuma vaga disponível no momento.")
  end

  it "and there are no job postings" do
    visit root_path

    expect(page).to have_content("Nenhuma vaga disponível no momento.")
  end
end
