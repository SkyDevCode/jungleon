package egovframework.itgcms.project.rent.service;

public class RentEnum {
	public enum FACILITY {//"킨스타워 대강당(150석)", "킨스타워 회의실(25석)", "제1비즈니스 중회의실(30석)"
		FAC01("1", "킨스타워 대강당(150석)"),
		FAC02("2", "킨스타워 회의실(25석)"),
		FAC03("3", "제1비즈니스센터 중회의실(30석)")
		;

		private String value;
		private String name;
		public String getValue() {
			return this.value;
		}
		public String getName() {
			return this.name;
		}
		private FACILITY(String value, String name) {
			this.value = value;
			this.name = name;
		}
	}

	public enum RENT_CUSTOMER {
		CUST01("1", "기업"),
		CUST02("2", "개인");

		private String value;
		private String name;
		public String getValue() {
			return this.value;
		}
		public String getName() {
			return this.name;
		}
		private RENT_CUSTOMER(String value, String name) {
			this.value = value;
			this.name = name;
		}
	}

	public enum RENT_MEET {
		MEET01("1", "세미나"),
		MEET02("2", "교육"),
		MEET03("3", "기타");

		private String value;
		private String name;
		public String getValue() {
			return this.value;
		}
		public String getName() {
			return this.name;
		}
		private RENT_MEET(String value, String name) {
			this.value = value;
			this.name = name;
		}
	}
	public enum RENT_EQUIPMENT {
		EQUIP01("1", "냉난방"),
		EQUIP02("2", "마이크 & 빔프로젝터")
		;

		private String value;
		private String name;
		public String getValue() {
			return this.value;
		}
		public String getName() {
			return this.name;
		}
		private RENT_EQUIPMENT(String value, String name) {
			this.value = value;
			this.name = name;
		}
	}
}
