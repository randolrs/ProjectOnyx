require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, company: { country: @company.country, datetime: @company.datetime, ein: @company.ein, exchange: @company.exchange, industry_group: @company.industry_group, name: @company.name, next_filing_date: @company.next_filing_date, sector: @company.sector, status: @company.status, sub_sector: @company.sub_sector, ticker: @company.ticker }
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, id: @company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company
    assert_response :success
  end

  test "should update company" do
    patch :update, id: @company, company: { country: @company.country, datetime: @company.datetime, ein: @company.ein, exchange: @company.exchange, industry_group: @company.industry_group, name: @company.name, next_filing_date: @company.next_filing_date, sector: @company.sector, status: @company.status, sub_sector: @company.sub_sector, ticker: @company.ticker }
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete :destroy, id: @company
    end

    assert_redirected_to companies_path
  end
end
